function out = objective(paras, Ft, P1_exp, time, num_eq, num_neq)
[mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d] = paras_to_array(paras, num_eq, num_neq);
P1_list = get_P1_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time);
out = (P1_exp - P1_list);
end