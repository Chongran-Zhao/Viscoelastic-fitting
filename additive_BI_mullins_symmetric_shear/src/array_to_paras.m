function [paras, num_eq, num_neq, lb, ub] = array_to_paras(mu_eq, m_eq, mu_neq, m_neq, eta_d, m, r, beta)
if length(mu_eq) == length(m_eq)
    num_eq = length(mu_eq);
else
    error("ERROR: Length of input parameters of equilibrium part don't match!");
end

if length(mu_neq) == length(m_neq)
    num_neq = length(mu_neq);
else
    error("ERROR: Length of input parameters of non-equilibrium part don't match!");
end

paras = [];
ub = [];
lb = [];
for ii = 1:num_eq
paras = [paras, mu_eq(ii), m_eq(ii)];
lb = [lb, 0, 0.5];
ub = [ub, Inf, 10];
end

for ii = 1:num_neq
paras = [paras, mu_neq(ii), m_neq(ii), eta_d(ii)];
lb = [lb, 0, 0.5, 0.0];
ub = [ub, Inf, 10, Inf];
end

end