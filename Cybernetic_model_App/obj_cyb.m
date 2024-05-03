function y_err = obj_cyb(logPar,par1,const,Par_size, Par_sp_size, Par_sub_size,Ci_time,Ci_data,Sj_time,Sj_data,Ci_max_data_time,Sj_max_data_time,n_species,n_substrates,Tjji,modelSel,cybsel)

Par = par1;
Par(~const) = 10.^logPar;

warning('off');

[mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,e_initial,err] = Par_list(Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates);

x_in = [Ci_data(1,:), Sj_data(1,:), e_initial, zeros(size(e_initial))];

[~,y_Ctime] = solve_cyb(Par,Par_size, Par_sp_size, Par_sub_size,Ci_time,x_in,n_species,n_substrates,Tjji,modelSel);
[~,y_Stime] = solve_cyb(Par,Par_size, Par_sp_size, Par_sub_size,Sj_time,x_in,n_species,n_substrates,Tjji,modelSel);

if length(y_Ctime(:,1))== length(Ci_time) && length(y_Stime(:,1))== length(Sj_time) && sum(isnan(Par))==0
    y_err1 = (y_Ctime(2:end,1:n_species)-Ci_data(2:end,:))./Ci_max_data_time(2:end,:);
    y_err2 = (y_Stime(2:end,n_species+1:n_species+n_substrates)-Sj_data(2:end,:))./Sj_max_data_time(2:end,:);
    
    y_err = [y_err1(:); y_err2(:)]';
    y_err(isnan(y_err)) = 0;
else
    y_err = ones(1,length(Ci_time)+length(Sj_time)-2).*10000;
end
