function [dx] = model_kin(~,x,Par,Par_size, Par_sp_size, Par_sub_size,n_species,n_substrates,Tjji)

x(x<0) = 0;
%% Initial conditions

Ci = x(1:n_species); Ci = Ci(:);
Sj = x(n_species+1:n_species+n_substrates); Sj = Sj(:);
eij = x(n_species+n_substrates+1:n_species+n_substrates+n_species*n_substrates); 
eij = reshape(eij,[n_species,n_substrates]);
Eij = x(n_species+n_substrates+n_species*n_substrates+1:n_species+n_substrates+2*n_species*n_substrates); 
Eij = reshape(Eij,[n_species,n_substrates]);

%% Parameter
[mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,~,~] = Par_list(Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates);
[mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t] = Par_model_resize(mu1,K,m,Y,k_c,K_c,f,k_e,alpha1,beta1,k_t,n_species,n_substrates, Par_sp_size, Par_sub_size);

K_e = K;
%% U and V
rho1 = zeros(n_species,n_substrates); 
u = zeros(n_species,n_substrates); v = zeros(n_species,n_substrates); 

emax  = zeros(n_species,n_substrates);

for i = 1:n_species
    for j = 1:n_substrates
%         emax(i,j) = (-beta1(i,j)+sqrt(beta1(i,j)^2+4*mu1(i,j)*(alpha1(i,j)+k_e(i,j))))/(2*mu1(i,j));
        emax(i,j) = (alpha1(i,j)+k_e(i,j))/(beta1(i,j));
    end
end

for i = 1:n_species
    for j = 1:n_substrates
        rho1(i,j) = mu1(i,j)*eij(i,j)/emax(i,j)*Ci(i)*(Sj(j))/(K(i,j)+Sj(j))/emax(i,j);
    end
end

for i = 1:n_species
    for j = 1:n_substrates
        u(i,j) = 1; v(i,j) = 1;
    end
end

%% ODEs
dCi = zeros(n_species,1); 
dSj = zeros(n_substrates,1); 
deij = zeros(n_species,n_substrates);
dEij = zeros(n_species,n_substrates);

for i=1:n_species
    dCi(i) = -m(i)*Ci(i);
    for j = 1:n_substrates
        dCi(i) = dCi(i) + rho1(i,j)*v(i,j);
    end
end

for j = 1:n_substrates
    for i=1:n_species
        dSj(j) = dSj(j)-(1/Y(i,j))*v(i,j)*rho1(i,j);
        temp = 0;
        for jj = 1:n_substrates
            temp = temp + eij(i,jj)/emax(i,j).*v(i,jj).*Tjji(jj,j,i).*k_c(i,jj).*Sj(jj)./(K_c(i,jj)+Sj(jj));
        end
        dSj(j) = dSj(j) + Ci(i).*temp;
        clear temp;
    end
end

if n_substrates>3
    for j = 1:n_substrates
        for i=1:n_species
            temp = 0;
            for jj = 4:n_substrates
                temp = temp - eij(i,jj)/emax(i,j).*v(i,jj).*Tjji(jj,j,i).*k_b(i,jj).*Sj(jj-1).*Sj(2)./(K_b(i,jj)+Sj(jj-1).*Sj(2));
            end
            dSj(j) = dSj(j) + Ci(i).*temp;
            clear temp;
        end
    end
end

for i=1:n_species
    for j = 1:n_substrates
        deij(i,j) = (alpha1(i,j)+k_e(i,j)*u(i,j)*Sj(j)/(K_e(i,j)+Sj(j)))...
            -(rho1(i,j)/Ci(i)+beta1(i,j)+k_t(i,j))*eij(i,j);
    end
end

for i=1:n_species
    for j = 1:n_substrates
        dEij(i,j) = k_t(i,j)*eij(i,j) - beta1(i,j)*Eij(i,j);
    end
end

%% 
dx = [dCi(:); dSj(:); deij(:); dEij(:)];

end

