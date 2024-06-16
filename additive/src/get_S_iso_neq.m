function out = get_S_iso_neq(mu_neq, m_neq, n_neq, F, Gamma)
out = contract( get_T_neq(mu_neq, m_neq, n_neq, F, Gamma), get_proj_Q_neq(m_neq, n_neq, Gamma));
end