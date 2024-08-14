function [paras, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq, m, r, beta)
num_eq = length(mu_eq);
num_neq = size(mu_neq, 2);
num_rel = length(eta);
if (size(mu_neq, 1) ~= num_rel)
error("ERROR: number of relaxation process doesn't match mu_neq!");
end
num_paras = 2*num_eq + num_rel + 2*num_neq*num_rel + 3;
lb = -Inf(num_paras, 1);
lb(end) = 0.0;
ub = Inf(num_paras, 1);
paras = [];
paras = [paras, mu_eq];
paras = [paras, alpha_eq];
paras = [paras, eta];
for ii = 1:length(eta)
    paras = [paras, mu_neq(ii,:)];
end

for ii = 1:length(eta)
    paras = [paras, alpha_neq(ii,:)];
end
paras = [paras, m, r, beta];
end
% EOF