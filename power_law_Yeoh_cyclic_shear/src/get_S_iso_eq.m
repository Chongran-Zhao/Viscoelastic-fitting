function out = get_S_iso_eq(xi_eq, F)
C = transpose(F)*F;
[V, D] = eig(C);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
lambda1_bar = lambda1 / (lambda1*lambda2*lambda3);
lambda2_bar = lambda2 / (lambda1*lambda2*lambda3);
lambda3_bar = lambda3 / (lambda1*lambda2*lambda3);
I1_bar = lambda1_bar*lambda1_bar + lambda2_bar*lambda2_bar + lambda3_bar*lambda3_bar;

summation = lambda1_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda1_bar)...
          + lambda2_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda2_bar)...
          + lambda3_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda3_bar);
summation = summation / 3.0;

S_eq_1 = (lambda1_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda1_bar) - summation) / lambda1^2;
S_eq_2 = (lambda2_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda2_bar) - summation) / lambda2^2;
S_eq_3 = (lambda3_bar * dPsi_dlambda_eq(xi_eq, I1_bar, lambda3_bar) - summation) / lambda3^2;
out = tensor_product(S_eq_1, S_eq_2, S_eq_3, N1, N2, N3);
end
% EOF