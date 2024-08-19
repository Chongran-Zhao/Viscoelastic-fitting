function out = get_tau_bar_neq(xi_neq, be_bar)
[V, D] = eig(be_bar);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda_e_bar_1 = sqrt(D(1,1));
lambda_e_bar_2 = sqrt(D(2,2));
lambda_e_bar_3 = sqrt(D(3,3));

I1_e_bar = lambda_e_bar_1*lambda_e_bar_1 + lambda_e_bar_2*lambda_e_bar_2 + lambda_e_bar_3*lambda_e_bar_3;

tau_bar_neq_1 = dPsi_dlambda_eq(xi_neq, I1_e_bar, lambda_e_bar_1) / lambda_e_bar_1;
tau_bar_neq_2 = dPsi_dlambda_eq(xi_neq, I1_e_bar, lambda_e_bar_2) / lambda_e_bar_2;
tau_bar_neq_3 = dPsi_dlambda_eq(xi_neq, I1_e_bar, lambda_e_bar_3) / lambda_e_bar_3;

out = tensor_product(tau_bar_neq_1, tau_bar_neq_2, tau_bar_neq_3, N1, N2, N3);
out = out * be_bar;
end