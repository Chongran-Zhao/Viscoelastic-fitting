function out = multi_objective(paras, Ft_1, P_shear_exp1, time_1,...
                                      Ft_2, P_shear_exp2, time_2,...
                                      num_eq, num_neq, num_rel)
[mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);

P_shear_list_1 = get_P_ij_list(1, 2, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_1, time_1);
P_shear_list_2 = get_P_ij_list(1, 2, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_2, time_2);

out = [];
for ii = 1:length(P_shear_exp1)
out = [out, P_shear_list_1(ii) - P_shear_exp1(ii)];
end
for ii = 1:length(P_shear_exp2)
out = [out, P_shear_list_2(ii) - P_shear_exp2(ii)];
end

end