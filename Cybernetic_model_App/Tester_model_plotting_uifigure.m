function Tester_model_plotting_uifigure
    
    colors = distinguishable_colors(10);
    set(0,'DefaultFigureColor','w');
    set(0,'DefaultAxesFontSize',24,'DefaultTextFontSize',24);
    set(0,'DefaultAxesFontName','Arial','DefaultTextFontName','Arial');
    set(0,'DefaultLineLinewidth',4);
    all_fig = findall(0, 'type', 'figure');
    close(all_fig)
    % Create table array
    
    [file,selFol] = uigetfile('*.xlsx');file_name1 = fullfile(selFol,file);
    table = readtable(file_name1,'ReadRowNames',true);
    table_org = table;

    % Create UI figure
    fig = uifigure('Name','Cybernetic multi-species model Tester','WindowState','maximized');
%     fig.Position = [1 82 1920 970];
    g = uigridlayout(fig,[4,3]);
    g.RowHeight = {50,'1x','1x',50};
    g.ColumnWidth = {'1x','1x','1x'};
    
    % title
    title = uilabel(g,'Text','Cybernetic multi-species model Tester');
    title.HorizontalAlignment = 'center';
    title.FontSize = 24;
    title.Layout.Row = 1;
    title.Layout.Column = [1,3];

    % Create table UI component
    uit = uitable(g,'FontSize',18);
    uit.Data = table;
    uit.ColumnSortable = true;
    uit.ColumnEditable = [false true];
%     uit.DisplayDataChangedFcn = @updatePlot;
    addStyle(uit,uistyle('HorizontalAlignment','center'),'table','');
    uit.Layout.Row = [2,3];
    uit.Layout.Column = 1;
    
       
    ax1 = uiaxes(g); ax1.Layout.Row = 2; ax1.Layout.Column = 2; ax1.XLabel.String = 'Time'; ax1.YLabel.String = 'Ci';
    ax2 = uiaxes(g); ax2.Layout.Row = 2; ax2.Layout.Column = 3; ax2.XLabel.String = 'Time'; ax2.YLabel.String = 'Sj';
    ax3 = uiaxes(g); ax3.Layout.Row = 3; ax3.Layout.Column = 2; ax3.XLabel.String = 'Time'; ax3.YLabel.String = 'eij';
    ax4 = uiaxes(g); ax4.Layout.Row = 3; ax4.Layout.Column = 3; ax4.XLabel.String = 'Time'; ax4.YLabel.String = 'Eij';
    
    assignin('base','Current_model',table);
    [t,Ci,Sj,eij,Eij,n_species,n_substrates] = solve_from_modelset(table);

    for i = 1:n_species
        plot(ax1,t,Ci(:,i),'Color', colors(i,:));hold(ax1,"on");
    end
    legend(ax1,{'C1','C2','C3'});
    ylim(ax1,[0 max(Ci*1.1,[],'all')]); xlim(ax1, [0 max(t)]);

    for j = 1:n_substrates
        plot(ax2,t,Sj(:,j),'Color', colors(n_species+j,:));hold(ax2,"on");
    end
    legend(ax2,{'S1','S2','S3','S4','S5'});
    ylim(ax2,[0 max(Sj*1.1,[],'all')]); xlim(ax2, [0 max(t)]);

    style = {'-','--',':','-.'};
    for j = 1:n_substrates
        for i= 1:n_species
            plot(ax3,t, eij(:,(j-1)*n_species+i),'Color',colors(n_species+j,:),'LineStyle',style{i});
            hold(ax3,"on");
%             plot(ax3,t, eij(:,(j-1)*n_species+i),'Color',colors(i,:),'LineStyle',style{3});
        end
    end
    ylim(ax3,[0 max(eij*1.1,[],'all')]); xlim(ax3, [0 max(t)]);

    for j = 1:n_substrates
        for i= 1:n_species
            plot(ax4,t, Eij(:,(j-1)*n_species+i),'Color',colors(n_species+j,:),'LineStyle',style{i});
            hold(ax4,"on");
%             plot(ax4,t, Eij(:,(j-1)*n_species+i),'Color',colors(i,:),'LineStyle',style{3});
        end
    end
    ylim(ax4,[0 max(max(Eij*1.1,[],'all'),10^-10)]); xlim(ax4, [0 max(t)]);
    hold(ax1,"off");hold(ax2,"off");hold(ax3,"off");hold(ax4,"off");

    % Load button
    b1 = uibutton(g,'Text','Load','FontSize',24);
    b1.Layout.Row = 4;
    b1.Layout.Column = 1;
    b1.ButtonPushedFcn = @LoadData;
    
    % Run button
    b2 = uibutton(g,'Text','Run','FontSize',24);
    b2.Layout.Row = 4;
    b2.Layout.Column = 2;
    b2.ButtonPushedFcn = @updatePlot;
    
    % Save button
    b3 = uibutton(g,'Text','Save','FontSize',24);
    b3.Layout.Row = 4;
    b3.Layout.Column = 3;
    b3.ButtonPushedFcn = @SaveData;
    
    function LoadData(~,~)
        [file,selFol] = uigetfile('*.xlsx');file_name1 = fullfile(selFol,file);
        table = readtable(file_name1,'ReadRowNames',true);
        table_org = table;
        uit.Data = table_org;
        updatePlot
        figure(fig);
    end
    function SaveData(~,~)
        startingFolder = pwd;
        defaultFileName = fullfile(startingFolder, '*.xlsx');
        [baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
        if baseFileName == 0
            % User clicked the Cancel button.
            return;
        end
        % Get base file name, so we can ignore whatever extension they may have typed in.
        [~, baseFileNameNoExt, ~] = fileparts(baseFileName);
        fullFileName = fullfile(folder, [baseFileNameNoExt, '.xlsx']);    % Force an extension of .xlsx.
        fullFileName2 = fullfile(folder, [baseFileNameNoExt, '.png']);
        % Now write the table to an Excel workbook.
        writetable(table, fullFileName,'WriteRowNames',true);
        try
            exportapp(fig,fullFileName2)
        catch
        end
    end

    % Export button
%     b2 = uibutton(g,'Text','Export');
%     b2.Layout.Row = 4;
%     b2.Layout.Column = 3;
%     b2.ButtonPushedFcn = @buttoncallback;

%     function buttoncallback(~,~)
%         filter = {'*.png'};
%         [filename,filepath] = uiputfile(filter);
%         if ischar(filename)
%             exportapp(fig,[filepath filename]);
%         end
%     end

    % Update the figures when table data changes
    function updatePlot(src,event)
        table = uit.DisplayData;
        assignin('base','Current_model',table);
        [t,Ci,Sj,eij,Eij,n_species,n_substrates] = solve_from_modelset(table);
        
        for ii = 1:n_species
            plot(ax1,t,Ci(:,ii),'Color', colors(ii,:));hold(ax1,"on");
        end
        legend(ax1,{'C1','C2','C3'});
        ylim(ax1,[0 max(Ci*1.1,[],'all')]); xlim(ax1, [0 max(t)]);

        for jj = 1:n_substrates
            plot(ax2,t,Sj(:,jj),'Color', colors(n_species+jj,:));hold(ax2,"on");
        end
        legend(ax2,{'S1','S2','S3','S4','S5'});
        ylim(ax2,[0 max(Sj*1.1,[],'all')]); xlim(ax2, [0 max(t)]);

        style = {'-','--',':','-.'};
        for jj = 1:n_substrates
            for ii= 1:n_species
                plot(ax3,t, eij(:,(jj-1)*n_species+ii),'Color',colors(n_species+jj,:),'LineStyle',style{ii});
                hold(ax3,"on");
%                 plot(ax3,t, eij(:,(jj-1)*n_species+ii),'Color',colors(ii,:),'LineStyle',style{3});
            end
        end
        ylim(ax3,[0 max(eij*1.1,[],'all')]); xlim(ax3, [0 max(t)]);

        for jj = 1:n_substrates
            for ii= 1:n_species
                plot(ax4,t, Eij(:,(jj-1)*n_species+ii),'Color',colors(n_species+jj,:),'LineStyle',style{ii});
                hold(ax4,"on");
%                 plot(ax4,t, Eij(:,(jj-1)*n_species+ii),'Color',colors(ii,:),'LineStyle',style{3});
            end
        end
        ylim(ax4,[0 max(max(Eij*1.1,[],'all'),10^-10)]); xlim(ax4, [0 max(t)]);
        hold(ax1,"off");hold(ax2,"off");hold(ax3,"off");hold(ax4,"off");
    end

end