function out = get_tau_iso_neq(xi_neq, be)
[V, D] = eig(be);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
I1 = D(1,1) + D(2,2) + D(3,3);
tau_1 = dPsi_dlambda_neq(xi_neq, I1, lambda1) * lambda1 - dPsi_dlambda_neq(xi_neq, I1, lambda2) * lambda2 / 3.0 - dPsi_dlambda_neq(xi_neq, I1, lambda3) * lambda3 / 3.0;
tau_2 = dPsi_dlambda_neq(xi_neq, I1, lambda2) * lambda2 - dPsi_dlambda_neq(xi_neq, I1, lambda3) * lambda3 / 3.0 - dPsi_dlambda_neq(xi_neq, I1, lambda1) * lambda1 / 3.0;
tau_3 = dPsi_dlambda_neq(xi_neq, I1, lambda3) * lambda3 - dPsi_dlambda_neq(xi_neq, I1, lambda2) * lambda2 / 3.0 - dPsi_dlambda_neq(xi_neq, I1, lambda1) * lambda1 / 3.0;
out = tensor_product(tau_1, tau_2, tau_3, N1, N2, N3);
end