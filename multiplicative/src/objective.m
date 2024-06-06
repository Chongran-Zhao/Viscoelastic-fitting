function out = objective(paras, Ft, P1_exp, time, num_eq, num_neq, num_rel)
[mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);

P1_list = get_P1_list(mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft, time);

out = (P1_exp - P1_list);
end