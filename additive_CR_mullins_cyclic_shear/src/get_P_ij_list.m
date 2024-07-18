function out = get_P_ij_list(ii, jj, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, zeta_infty, lota, Ft, time)
out = zeros(length(time), 1);
P_pre = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time);
alpha_t = get_alpha_t(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time);
zeta_t = get_zeta_t(zeta_infty, lota, alpha_t);
for kk = 1:length(time)
out(kk) = (1.0 - zeta_t(kk)) * P_pre(ii,jj,kk);
end
end