function out = get_P_ij_list(ii, jj, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, F_list, time)
P_list = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, F_list, time);
out = zeros(size(time));
out(:) = P_list(ii, jj, :);
end