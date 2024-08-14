function out = get_eta_t(mu_eq, alpha_eq, mu_neq, alpha_neq, eta_d, m, r, beta, Ft, time)
out = zeros(length(time), 1);
Psi = zeros(length(time), 1);
max_Psi = 0.0;
for ii = 1:length(time)
    F = Ft(:,:,ii);
    C = F' * F;
    Psi(ii) = Psi(ii) + get_Ogden_energy_eq(mu_eq, alpha_eq, C);
end
for ii = 1:length(eta_d)
    be_t = get_be_t(time, mu_neq(:,ii), alpha_neq(:,ii), eta_d(ii), Ft);
    for jj = 1:length(time)
        Psi(jj) = Psi(jj) + get_Ogden_energy_neq(mu_neq(:,ii), alpha_neq(:,ii), be_t(:,:,jj));
    end
end
for ii = 1:length(time)
    if Psi(ii) >= max_Psi
        max_Psi = Psi(ii);
    end
    out(ii) = 1.0 - erf( (max_Psi - Psi(ii)) / (m + beta * max_Psi)) / r;
end
end