function [paras, num_eq, num_neq, lb, ub] = array_to_paras(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d)
if length(mu_eq) == length(m_eq) && length(m_eq) == length(n_eq)
    num_eq = length(mu_eq);
else
    error("ERROR: Length of input parameters of equilibrium part don't match!");
end

if length(mu_neq) == length(m_neq) && length(m_neq) == length(n_neq) && length(n_neq) == length(eta_d)
    num_neq = length(mu_neq);
else
    error("ERROR: Length of input parameters of non-equilibrium part don't match!");
end

paras = [];
for ii = 1:num_eq
    paras = [paras, mu_eq(ii), m_eq(ii), n_eq(ii)];
end

for ii = 1:num_neq
    paras = [paras, mu_neq(ii), m_neq(ii), n_neq(ii), eta_d(ii)];
end
lb = -Inf(3*num_eq + 4*num_neq, 1);
ub = Inf(3*num_eq + 4*num_neq, 1);
end