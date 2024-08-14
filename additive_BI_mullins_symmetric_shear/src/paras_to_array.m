function [mu_eq, m_eq, mu_neq, m_neq, eta_d, m, r, beta] = paras_to_array(paras, num_eq, num_neq)
mu_eq = [];
m_eq  = [];
for ii = 1:num_eq
    mu_eq = [mu_eq, paras(2*(ii-1)+1)];
    m_eq = [m_eq, paras(2*(ii-1)+2)];
end


mu_neq = [];
m_neq = [];
eta_d = [];
for ii = 1:num_neq
    mu_neq = [mu_neq, paras(2*num_eq+3*(ii-1)+1)];
    m_neq = [m_neq, paras(2*num_eq+3*(ii-1)+2)];
    eta_d = [eta_d, paras(2*num_eq+3*(ii-1)+3)];
end
m = paras(end-2);
r = paras(end-1);
beta = paras(end);
end