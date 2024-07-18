function out = get_alpha_t(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time)
out = zeros(length(time), 1);
Psi = zeros(length(time), 1);
for ii = 1:length(time)
    F = Ft(:,:,ii);
    C = F' * F;
    Psi(ii) = get_CR_energy_eq(mu_eq, m_eq, n_eq, C);
    for jj = 1:length(mu_neq)
        Ev_t = get_Ev_t(mu_neq, m_neq, n_neq, eta_d(jj), Ft, time);
        Psi(ii) = Psi(ii) + get_CR_energy_neq(mu_neq(jj), m_neq(jj), n_neq(jj), C, Ev_t(:,:,ii));
    end
end
for ii = 1:length(time)
    out(ii) = max(Psi(1:ii));
end
end