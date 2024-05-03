function [mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,e_initial,err] = Par_list(Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates)

err = false;
kkk = cumsum(Par_size); 
in = 1;

mu1 = Par(1:kkk(in));
if length(mu1) == 1
elseif length(mu1) == n_species*n_substrates
    mu1 = reshape(mu1,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    mu1 = reshape(mu1,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    mu1 = reshape(mu1,[1,n_substrates]);
else
    err = true;
end
in = in+1;

K = Par(kkk(in-1)+1:kkk(in));
if length(K) == 1
elseif length(K) == n_species*n_substrates
    K = reshape(K,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    K = reshape(K,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    K = reshape(K,[1,n_substrates]);
else
    err = true;
end
in = in+1;

m = Par(kkk(in-1)+1:kkk(in));
if length(m) == 1
elseif Par_sp_size(in) == n_species
    m = reshape(m,[n_species,1]);
else
    err = true;
end
in = in+1;

Y = Par(kkk(in-1)+1:kkk(in));
if length(Y) == 1
elseif length(Y) == n_species*n_substrates
    Y = reshape(Y,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    Y = reshape(Y,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    Y = reshape(Y,[1,n_substrates]);
else
    err = true;
end
in = in+1;

k_c = Par(kkk(in-1)+1:kkk(in));
if length(k_c) == 1
elseif length(k_c) == n_species*n_substrates
    k_c = reshape(k_c,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    k_c = reshape(k_c,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    k_c = reshape(k_c,[1,n_substrates]);
else
    err = true;
end
in = in+1;

K_c = Par(kkk(in-1)+1:kkk(in));
if length(K_c) == 1
elseif length(K_c) == n_species*n_substrates
    K_c = reshape(K_c,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    K_c = reshape(K_c,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    K_c = reshape(K_c,[1,n_substrates]);
else
    err = true;
end
in = in+1;

f = Par(kkk(in-1)+1:kkk(in));
if length(f) == 1
elseif Par_sp_size(in) == n_species
    f = reshape(f,[n_species,1]);
else
    err = true;
end
in = in+1;

k_e = Par(kkk(in-1)+1:kkk(in));
if length(k_e) == 1
elseif length(k_e) == n_species*n_substrates
    k_e = reshape(k_e,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    k_e = reshape(k_e,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    k_e = reshape(k_e,[1,n_substrates]);
else
    err = true;
end
in = in+1;

alpha1 = Par(kkk(in-1)+1:kkk(in));
if length(alpha1) == 1
elseif length(alpha1) == n_species*n_substrates
    alpha1 = reshape(alpha1,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    alpha1 = reshape(alpha1,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    alpha1 = reshape(alpha1,[1,n_substrates]);
else
    err = true;
end
in = in+1;

beta1 = Par(kkk(in-1)+1:kkk(in));
if length(beta1) == 1
elseif length(beta1) == n_species*n_substrates
    beta1 = reshape(beta1,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    beta1 = reshape(beta1,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    beta1 = reshape(beta1,[1,n_substrates]);
else
    err = true;
end
in = in+1;

k_t = Par(kkk(in-1)+1:kkk(in));
if length(k_t) == 1
elseif length(k_t) == n_species*n_substrates
    k_t = reshape(k_t,[n_species,n_substrates]);
elseif Par_sp_size(in) == n_species
    k_t = reshape(k_t,[n_species,1]);
elseif Par_sub_size(in) == n_substrates
    k_t = reshape(k_t,[1,n_substrates]);
else
    err = true;
end
in = in+1;

e_initial = Par(kkk(in-1)+1:kkk(in));
if length(e_initial) == n_species*n_substrates
    e_initial = reshape(e_initial,[1,n_species*n_substrates]);
else
    err = true;
end
in = in+1;



