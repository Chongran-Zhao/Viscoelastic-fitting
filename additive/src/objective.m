function out = objective(paras, Ft, P1_exp, time, num_eq, num_neq)
[mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_list] = paras_to_array(paras, num_eq, num_neq);
P1_list = get_P_ij_list(1, 1, mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_list, Ft, time);
out = [];
for ii = 1:length(P1_list)
    out = [out, P1_exp(ii) - P1_list(ii)];
end
end