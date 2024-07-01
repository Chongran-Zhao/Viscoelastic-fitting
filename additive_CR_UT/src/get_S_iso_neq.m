function out = get_S_iso_neq(mu_neq, m_neq, n_neq, C, Gamma)
out = contract( get_T_neq(mu_neq, m_neq, n_neq, C, Gamma), get_proj_Q(m_neq, n_neq, C));
end