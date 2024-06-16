function out = get_P1_list(mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time)
out = zeros(1, length(time));
P_list = get_P_list(mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time);
out(:) = P_list(1,1,:);
end