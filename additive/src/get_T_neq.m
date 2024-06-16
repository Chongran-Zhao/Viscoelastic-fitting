% The function is used to obtain the stress-like tensor T of non-equilibrium part,
% which is conjugated with generalized strain (E - Ev)
% refer to sec. 2.3 of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_T_neq(mu_neq, m_neq, n_neq, F, Gamma)
C = transpose(F) * F;
out = 2.0 .* mu_neq .* (get_CR_strain(m_neq, n_neq, C) - get_CR_strain(m_neq, n_neq, Gamma));
end