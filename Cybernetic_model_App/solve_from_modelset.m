function [t,Ci,Sj,eij,Eij,n_species,n_substrates] = solve_from_modelset(table)

Pref_Par_order = ["mu1";"K";"m";"Y";"k_c";"K_c";"f";"k_e";"alpha1";"beta1";"k_t";"e_initial"];

eval(strjoin(strcat(Pref_Par_order,"=str2num(string(table{'",Pref_Par_order,"',2}));")));
eval(strcat("Par=[", strjoin(strcat(Pref_Par_order,"(:)"),";"), "];"));
eval(strcat("Par_size=[", strjoin(strcat("(length(",Pref_Par_order,"(:)))"),";"),"];"));

eval(strcat("Par_sp_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",2)))"),";"),"];"));
eval(strcat("Par_sub_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",1)))"),";"),"];"));

eval("n_species=str2num(string(table{'n_species',2}));");
eval("n_substrates=str2num(string(table{'n_substrates',2}));");
eval("tmax=str2num(string(table{'tmax',2}));");
eval("Ci_initial=str2num(string(table{'Ci_initial',2}));");
eval("Sj_initial=str2num(string(table{'Sj_initial',2}));");
eval("Tjji=str2num(string(table{'Tjji',2}));");
Tjji = reshape(Tjji,n_substrates,n_substrates,n_species);

[mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,e_initial,err] = Par_list(Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates);

if err==true
    error("Incorrect initial parameter dimensions")
end

x_in = [Ci_initial, Sj_initial, e_initial, zeros(size(e_initial))];

opts = odeset('NonNegative',ones(1,length(x_in)),'RelTol',1e-13);

[t,y] = ode23(@(t,y) model_cyb(t,y,Par,Par_size, Par_sp_size, Par_sub_size,n_species,n_substrates,Tjji),[0 tmax],x_in,opts);

Ci = y(:,1:n_species);
Sj = y(:,n_species+1:n_species+n_substrates);
eij = y(:,n_species+n_substrates+1:n_species+n_substrates+n_species*n_substrates);
Eij = y(:,n_species+n_substrates+n_species*n_substrates+1:n_species+n_substrates+2*n_species*n_substrates);

