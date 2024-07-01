function out = get_P_iso_neq(mu_neq, m_neq, n_neq, F, Gamma)
C = F' * F;
out = F * get_S_iso_neq(mu_neq, m_neq, n_neq, C, Gamma);
end