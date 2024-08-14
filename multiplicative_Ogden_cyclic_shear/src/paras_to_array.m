function [mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq, m, r, beta] = paras_to_array(paras, num_eq, num_neq, num_rel)
mu_eq = paras(1:num_eq);
alpha_eq = paras(num_eq+1:2*num_eq);
eta_list = paras(2*num_eq+1:2*num_eq+num_rel);
mu_neq = zeros(num_neq, num_rel);
alpha_neq = zeros(num_neq, num_rel);
for ii = 1:num_rel
    mu_neq(:,ii) = paras(2*num_eq+num_rel+(ii-1)*num_neq+1:2*num_eq+num_rel+ii*num_neq);
    alpha_neq(:,ii) = paras(2*num_eq+num_rel+num_rel*num_neq+(ii-1)*num_neq+1:2*num_eq+num_rel+num_rel*num_neq+ii*num_neq);
end
m = paras(end-2);
r = paras(end-1);
beta = paras(end);
end