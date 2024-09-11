function out = get_S_iso_eq(mu, m, n, F)
C = F' * F;
[V, D] = eig(C);
lambda1 = D(1,1);
lambda2 = D(2,2);
lambda3 = D(3,3);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);

detF = sqrt(lambda1*lambda2*lambda3);
detFm0d33 = detF^(-1.0/3.0);
detFm0d66 = detF^(-2.0/3.0);

lambda1_bar = detFm0d33 * lambda1;
lambda2_bar = detFm0d33 * lambda2;
lambda3_bar = detFm0d33 * lambda3;

S_bar = zeros(3,3);
for ii = 1:length(mu)
    E_bar = get_gen_strain(m(ii), n(ii), lambda1_bar, lambda2_bar, lambda3_bar, N1, N2, N3);
    T_bar = get_gen_stress(mu(ii), E_bar);
    Q_bar = get_proj_Q(m(ii), n(ii), lambda1_bar, lambda2_bar, lambda3_bar, N1, N2, N3);
    S_bar = S_bar + contract(T_bar, Q_bar);
end
out = detFm0d66 .* DEV(S_bar, C);
end