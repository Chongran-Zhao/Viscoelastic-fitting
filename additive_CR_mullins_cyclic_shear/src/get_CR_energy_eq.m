function out = get_CR_energy_eq(mu_eq, m_eq, n_eq, C)
out = 0.0;
for ii = 1:length(mu_eq)
E = get_CR_strain(m_eq(ii), n_eq(ii), C);
out = out + mu_eq(ii) * contract(E, E);
end
end