function out = get_P_ij_list(ii, jj, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, p, alpha, Ft, time)
out = zeros(length(time), 1);
P_pre = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, p, alpha, Ft, time);
out(:) = P_pre(ii,jj,:);
end