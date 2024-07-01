function out = get_P_ij_list(ii, jj, mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_list, Ft, time)
out = zeros(length(time), 1);
P_list = get_P_list(mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_list, Ft, time);
out(:) = P_list(ii,jj,:);
end