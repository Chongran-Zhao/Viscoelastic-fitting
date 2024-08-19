function out = get_S_bar_eq(xi_eq, F_bar)
C_bar = transpose(F_bar)*F_bar;
[V, D] = eig(C_bar);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda1_bar = sqrt(D(1,1));
lambda2_bar = sqrt(D(2,2));
lambda3_bar = sqrt(D(3,3));

I1_bar = lambda1_bar*lambda1_bar + lambda2_bar*lambda2_bar + lambda3_bar*lambda3_bar;

S_bar_eq_1 = dPsi_dlambda_eq(xi_eq, I1_bar, lambda1_bar) / lambda1_bar;
S_bar_eq_2 = dPsi_dlambda_eq(xi_eq, I1_bar, lambda2_bar) / lambda2_bar;
S_bar_eq_3 = dPsi_dlambda_eq(xi_eq, I1_bar, lambda3_bar) / lambda3_bar;

out = tensor_product(S_bar_eq_1, S_bar_eq_2, S_bar_eq_3, N1, N2, N3);
end