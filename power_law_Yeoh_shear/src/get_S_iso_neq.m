% mu_neq and alpha_neq are parameter arrays with same length
% F is the 3x3 deformation gradient at one specific time
% be is the elastic left-Cauchy Green strain tensor at one specific time
% out is a 3x3 2nd PK stress tensor of none-equlibrium part at cooresponding time

function out = get_S_iso_neq(xi_neq, Fe, F)
Fv = F * inv(Fe);
Ce = Fe' * Fe;
[V, D] = eig(Ce);
I1 = D(1,1) + D(2,2) + D(3,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));

eig_val_S_eq = [dPsi_dlambda_eq(xi_neq, I1, lambda1) / lambda1;...
                dPsi_dlambda_eq(xi_neq, I1, lambda2) / lambda2;...
                dPsi_dlambda_eq(xi_neq, I1, lambda3) / lambda3];
out = tensor_product(V, eig_val_S_eq);
out = inv(Fv) * out * inv(Fv');
end
% EOF