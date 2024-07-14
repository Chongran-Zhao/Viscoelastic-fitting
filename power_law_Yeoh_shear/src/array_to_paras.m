function [paras, lb, ub] = array_to_paras(xi_eq, xi_neq, tau_hat, power_m)
paras = [xi_eq, xi_neq, tau_hat, power_m];
num_paras = length(paras);
lb = -Inf(num_paras, 1);
ub = Inf(num_paras, 1);
end
% EOF