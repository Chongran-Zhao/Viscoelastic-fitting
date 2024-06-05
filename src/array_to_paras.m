function [paras, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq)
num_eq = length(mu_eq);
num_neq = size(mu_neq, 1);
num_rel = length(eta);

num_paras = 2*num_eq + num_rel + 2*num_neq*num_rel;
lb = zeros(num_paras, 1);
ub = Inf(num_paras, 1);

paras = [];
paras = [paras, mu_eq];
paras = [paras, alpha_eq];
paras = [paras, eta];
for ii = 1:size(mu_neq, 2)
    paras = [paras, mu_neq(ii,:)];
end

for ii = 1:size(alpha_neq, 2)
    paras = [paras, alpha_neq(ii,:)];
end
end
% EOF