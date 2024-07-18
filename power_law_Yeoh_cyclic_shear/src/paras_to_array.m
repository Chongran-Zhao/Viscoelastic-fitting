function [xi_eq, xi_neq, tau_hat, power_m] = paras_to_array(paras)
xi_eq = paras(1:3);
xi_neq = paras(4:6);
tau_hat = paras(7);
power_m = paras(8);
end