function out = objective(paras, Ft, P_exp, time, num_eq, num_neq)
[mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, zeta_infty, iota] = paras_to_array(paras, num_eq, num_neq, Ft, P_exp, time);
P_pre = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, zeta_infty, iota, Ft, time);
out = [];
for ii = 1:length(P_pre)
    out = [out, P_exp(ii) - P_pre(ii)];
end
end