function [t,y] = solve_cyb(Par,Par_size, Par_sp_size, Par_sub_size,time,x_in,n_species,n_substrates,Tjji,modelSel)

opts = odeset('NonNegative',ones(1,length(x_in)),'RelTol',1e-13);

if modelSel==1
    [t,y] = ode23(@(t,y) model_kin(t,y,Par,Par_size, Par_sp_size, Par_sub_size,n_species,n_substrates,Tjji),time,x_in,opts);
elseif modelSel ==2
    [t,y] = ode23(@(t,y) model_cyb(t,y,Par,Par_size, Par_sp_size, Par_sub_size,n_species,n_substrates,Tjji),time,x_in,opts);
end
