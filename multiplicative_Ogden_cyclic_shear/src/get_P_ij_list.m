function out = get_P_ij_list(ii, jj, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_d, m, r, beta, Ft, time)
out = zeros(length(time), 1);
P_list = get_P_list(mu_eq, alpha_eq, mu_neq, alpha_neq, eta_d, Ft, time);
eta_t = get_eta_t(mu_eq, alpha_eq, mu_neq, alpha_neq, eta_d, m, r, beta, Ft, time);
for kk = 1:length(time)
out(kk) = eta_t(kk) * P_list(ii,jj,kk);
end
end