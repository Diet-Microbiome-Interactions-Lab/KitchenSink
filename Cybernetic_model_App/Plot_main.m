clear
clc
close all

colors = distinguishable_colors(10);
set(0,'DefaultFigureColor','w');
set(0,'DefaultAxesFontSize',10,'DefaultTextFontSize',10);
set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial');
set(0,'DefaultLineLinewidth',1.5);

Plot_best_solution = 1;

%% Load data
[file,selFol] = uigetfile('*.mat');
[~,file_name,~] = fileparts(file);

file_name1 = fullfile(selFol,[file_name,'.xlsx']);
[Ci_time,Ci_data,Sj_time,Sj_data,Species,Substrates,Enzymes,n_species,n_substrates,Tjji] = load_from_table(file_name1);

mfilename = fullfile(selFol,strcat(file_name,".mat"));
load(mfilename);
[~,in]=sort(cell2mat(solutions(2,2:end)));
solutions_sorted = solutions(:,[1,in+1]);

for i = 4:length(solutions_sorted(:,1))
    eval(strcat(string(solutions_sorted(i,1)),"=",mat2str(solutions_sorted{i,1+Plot_best_solution}),";"));
end

if strcmp(solutions_sorted{1,1+Plot_best_solution},'Cybernetic')
    modelSel=2;
elseif strcmp(solutions_sorted{1,1+Plot_best_solution},'kinetic')
    modelSel=1;
end


%% Plot data
h1 = figure;
set(h1,'Units','centimeters');
set(h1,'position',[2,2,20,15])
t1= tiledlayout(2,2);

ax(1) = nexttile(t1,1); hold(ax(1),"on")
for i = 1:n_species
    plot(ax(1),Ci_time,Ci_data(:,i),'o','Color', colors(i,:));
end
ylabel(ax(1),'Species Concentration');
legend(ax(1),Species,'Location','Best')
ylim(ax(1),[0 1.1*max(Ci_data,[],'all')]);
xlim(ax(1),[0 max([Ci_time;Sj_time])])

ax(2) = nexttile(t1,2); hold(ax(2),"on")
for j = 1:n_substrates
    plot(ax(2),Sj_time,Sj_data(:,j),'o','Color', colors(n_species+j,:));
end
ylabel(ax(2),'Substrate Concentration');
legend(ax(2),Substrates,'Location','Best');
ylim(ax(2),[0 1.1*max(Sj_data,[],'all')]);
xlim(ax(2),[0 max([Ci_time;Sj_time])])

ax(3) = nexttile(t1,3); hold(ax(3),"on")
ylabel(ax(3),'Intracellular Enzyme Concentration');
legend(ax(3),Enzymes,'Location','Best'); 
% ylim(ax(3),[0 1]);
xlim(ax(3),[0 max([Ci_time;Sj_time])])

ax(4) = nexttile(t1,4); hold(ax(4),"on")
ylabel(ax(4),'Extracellular Enzyme Concentration');
legend(ax(4),Enzymes,'Location','Best'); 
% ylim(ax(4),[0 1]);
xlim(ax(4),[0 max([Ci_time;Sj_time])])

linkaxes(ax,'x');
xlabel(t1,'time (hr)');

pos = get(h1,'Position');
set(h1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])

%%
Pref_Par_order = ["mu1";"K";"m";"Y";"k_c";"K_c";"f";"k_e";"alpha1";"beta1";"k_t";"e_initial"];
eval(strcat("Par=[", strjoin(strcat(Pref_Par_order,"(:)"),";"), "];"));
eval(strcat("Par_size=[", strjoin(strcat("(length(",Pref_Par_order,"(:)))"),";"),"];"));
eval(strcat("Par_sp_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",2)))"),";"),"];"));
eval(strcat("Par_sub_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",1)))"),";"),"];"));

[mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,e_initial,err] = Par_list(Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates);

x_in = [Ci_data(1,:), Sj_data(1,:), e_initial, zeros(size(e_initial))];
            
[t,y] = solve_cyb(Par,Par_size, Par_sp_size, Par_sub_size,[min([Ci_time; Sj_time]) max([Ci_time; Sj_time])],x_in,n_species,n_substrates,Tjji,modelSel);
Ci = y(:,1:n_species);
Sj = y(:,n_species+1:n_species+n_substrates);
eij = y(:,n_species+n_substrates+1:n_species+n_substrates+n_species*n_substrates);
Eij = y(:,n_species+n_substrates+n_species*n_substrates+1:n_species+n_substrates+2*n_species*n_substrates);

ax_ind =1;
for i = 1:n_species
    ax_num(ax_ind)= plot(ax(1),t,Ci(:,i),'Color', colors(i,:));
    ax_ind = ax_ind+1;
end
legend(ax(1),Species,'Location','Best')

for j = 1:n_substrates
    ax_num(ax_ind)= plot(ax(2),t,Sj(:,j),'Color', colors(n_species+j,:));
    ax_ind = ax_ind+1;
end
legend(ax(2),Substrates,'Location','Best');

style = {'-','--',':','-.'};
for j = 1:n_substrates
    for i= 1:n_species
        ax_num(ax_ind)= plot(ax(3),t, eij(:,(j-1)*n_species+i),'Color',colors(n_species+j,:),'LineStyle',style{i});
        ax_ind = ax_ind+1;
    end
end
legend(ax(3),ax_num((ax_ind-n_species*n_substrates):ax_ind-1),Enzymes,'Location','Best');

for j = 1:n_substrates
    for i= 1:n_species
        ax_num(ax_ind)= plot(ax(4),t, Eij(:,(j-1)*n_species+i),'Color',colors(n_species+j,:),'LineStyle',style{i});
        ax_ind = ax_ind+1;
    end
end
legend(ax(4),ax_num((ax_ind-n_species*n_substrates):ax_ind-1),Enzymes,'Location','Best');

file_name2 = strcat(selFol,file_name,".svg");
% exportgraphics(t1,file_name2,'ContentType','vector')
print(h1,file_name2,'-dsvg','-vector')