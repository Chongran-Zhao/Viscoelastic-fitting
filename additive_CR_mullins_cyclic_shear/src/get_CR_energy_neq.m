function out = get_CR_energy_neq(mu_neq, m_neq, n_neq, C, Ev)
E = get_CR_strain(m_neq, n_neq, C);
out = mu_neq * contract(E-Ev, E-Ev);
end