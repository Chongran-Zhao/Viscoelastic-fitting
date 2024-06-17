% mu_eq and alpha_eq are parameter arrays
% F is the 3x3 deformation gradient at one specific time
% out is a 3x3 2nd PK stress tensor of equlibrium part at cooresponding time

function out = get_S_iso_eq(xi_eq, F)
C = transpose(F)*F;
[V, D] = eig(C);
I1 = D(1,1) + D(2,2) + D(3,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));

eig_val_S_eq = [dPsi_dlambda_eq(xi_eq, I1, lambda1) / lambda1;...
                dPsi_dlambda_eq(xi_eq, I1, lambda2) / lambda2;...
                dPsi_dlambda_eq(xi_eq, I1, lambda3) / lambda3];
out = tensor_product(V, eig_val_S_eq);
end
% EOF