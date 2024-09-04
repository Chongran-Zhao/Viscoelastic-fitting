function [paras, lb, ub] = array_to_paras(xi_eq, xi_neq, C1, C2, tau_hat, power_m)
paras = [];
lb = [-Inf, -Inf, -Inf];
ub = [Inf, Inf, Inf];
paras = [paras, xi_eq];
for ii = 1:length(C1)
    paras = [paras, xi_neq(ii,:), C1(ii), C2(ii), tau_hat(ii), power_m(ii)];
    lb = [lb, -Inf, -Inf, -Inf,  0.0, -1.0, 1.0, 2.0];
    ub = [ub, Inf, Inf, Inf,     Inf, 0.0, Inf, Inf];
end
end
% EOF