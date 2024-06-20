function out = objective(paras, Ft, P1_exp, time, num_eq, num_neq, num_rel)
[mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);

P1_list = get_P_ij_list(1, 2, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft, time);
out = [];
for ii = 1:length(P1_exp)
out = [out, P1_exp(ii) - P1_list(ii)];
end
end