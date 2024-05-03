function [mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t] = Par_model_resize(mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,n_species,n_substrates, Par_sp_size, Par_sub_size)
in = 1;
if length(mu1) == n_species*n_substrates
elseif length(mu1) == 1
    mu1 = repmat(mu1,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    mu1 = repmat(mu1,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    mu1 = repmat(mu1,n_species,1);
end
in = in+1;

if length(K) == n_species*n_substrates
elseif length(K) == 1
    K = repmat(K,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    K = repmat(K,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    K = repmat(K,n_species,1);
end
in = in+1;

if length(m) == n_species
elseif length(m) == 1
    m = repmat(m,n_species,1);
end
in = in+1;

if length(Y) == n_species*n_substrates
elseif length(Y) == 1
    Y = repmat(Y,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    Y = repmat(Y,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    Y = repmat(Y,n_species,1);
end
in = in+1;

if length(k_c) == n_species*n_substrates
elseif length(k_c) == 1
    k_c = repmat(k_c,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    k_c = repmat(k_c,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    k_c = repmat(k_c,n_species,1);
end
in = in+1;

if length(K_c) == n_species*n_substrates
elseif length(K_c) == 1
    K_c = repmat(K_c,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    K_c = repmat(K_c,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    K_c = repmat(K_c,n_species,1);
end
in = in+1;

if length(f) == n_species
elseif length(f) == 1
    f = repmat(f,n_species,1);
end
in = in+1;

if length(k_e) == n_species*n_substrates
elseif length(k_e) == 1
    k_e = repmat(k_e,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    k_e = repmat(k_e,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    k_e = repmat(k_e,n_species,1);
end
in = in+1;

if length(alpha1) == n_species*n_substrates
elseif length(alpha1) == 1
    alpha1 = repmat(alpha1,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    alpha1 = repmat(alpha1,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    alpha1 = repmat(alpha1,n_species,1);
end
in = in+1;

if length(beta1) == n_species*n_substrates
elseif length(beta1) == 1
    beta1 = repmat(beta1,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    beta1 = repmat(beta1,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    beta1 = repmat(beta1,n_species,1);
end
in = in+1;

if length(k_t) == n_species*n_substrates
elseif length(k_t) == 1
    k_t = repmat(k_t,n_species,n_substrates);
elseif Par_sp_size(in) == n_species
    k_t = repmat(k_t,1,n_substrates);
elseif Par_sub_size(in) == n_substrates
    k_t = repmat(k_t,n_species,1);
end