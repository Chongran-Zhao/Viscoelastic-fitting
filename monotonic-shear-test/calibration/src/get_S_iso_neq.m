function out = get_S_iso_neq(mu, m, n, eta, F_new, F_old, dt)
C_new = F_new' * F_new;
[V, D] = eig(C_new);
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
    Ev = get_Ev(mu(ii), m(ii), n(ii), eta(ii), F_old, F_new, dt);
    T_bar = get_gen_stress(mu(ii), E_bar - Ev);
    Q_bar = get_proj_Q(m(ii), n(ii), lambda1_bar, lambda2_bar, lambda3_bar, N1, N2, N3);
    S_bar = S_bar + contract(T_bar, Q_bar);
end
out = detFm0d66 .* DEV(S_bar, C_new);
end