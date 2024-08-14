function out = get_S_iso_eq(mu_eq, m_eq, C)
out = contract(get_T_eq(mu_eq, m_eq, C), get_proj_Q(m_eq, C));
end