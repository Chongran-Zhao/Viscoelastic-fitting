function [paras, lb, ub, num_eq, num_neq] = array_to_paras(xi_eq, xi_neq, eta_d)
num_eq = length(xi_eq);
num_neq = length(xi_neq);

num_paras = num_eq + num_neq + 1;
lb = -Inf(num_paras, 1);
ub = Inf(num_paras, 1);
lb(end) = 0.0;

paras = [];
paras = [paras, xi_eq];
paras = [paras, xi_neq];
paras = [paras, eta_d];
end
% EOF