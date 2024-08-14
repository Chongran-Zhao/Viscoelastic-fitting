function out = objective(paras, Ft, P_exp, time, num_eq, num_neq, num_rel)
[mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq, m, r, beta] = paras_to_array(paras, num_eq, num_neq, num_rel);

P_pre = get_P_ij_list(1, 2, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, m, r, beta, Ft, time);
out = [];
for ii = 1:length(P_exp)
out = [out, P_exp(ii) - P_pre(ii)];
end
end