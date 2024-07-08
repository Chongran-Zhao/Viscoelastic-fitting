function [xi_eq, xi_neq, eta_d] = paras_to_array(paras, num_eq, num_neq)
xi_eq = paras(1:num_eq);
xi_neq = paras(num_eq+1:num_eq+num_neq);
eta_d = paras(end);
end