function out = get_CR_energy_eq(mu_eq, m_eq, n_eq, C)
out = 0.0;
for ii = 1:length(mu_eq)
E = get_CR_strain(m_eq(ii), n_eq(ii), C);
out = out + mu_eq(ii)...
    * ( E(1,1)*E(1,1) + E(1,2)*E(1,2) + E(1,3)*E(1,3)...
      + E(2,1)*E(2,1) + E(2,2)*E(2,2) + E(2,3)*E(2,3)...
      + E(3,1)*E(3,1) + E(3,2)*E(3,2) + E(3,3)*E(3,3));
end
end