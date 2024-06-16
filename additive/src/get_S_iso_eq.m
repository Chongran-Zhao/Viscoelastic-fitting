function out = get_S_iso_eq(mu_eq, m_eq, n_eq, F)
out = contract(get_T_eq(mu_eq, m_eq, n_eq, F), get_proj_Q_eq(m_eq, n_eq, F));
end