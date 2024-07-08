function out = multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                      Ft_2, P_exp_2, time_2,...
                                      Ft_3, P_exp_3, time_3,...
                                      Ft_4, P_exp_4, time_4,...
                                      Ft_5, P_exp_5, time_5,...
                                      num_eq, num_neq, num_rel)
[mu_eq, alpha_eq, eta_list, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);

P_pre_1 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_1, time_1);
P_pre_2 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_2, time_2);
P_pre_3 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_3, time_3);
P_pre_4 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_4, time_4);
P_pre_5 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta_list, Ft_5, time_5);

out = [];
for ii = 1:length(P_exp_1)
out = [out, P_pre_1(ii) - P_exp_1(ii)];
end
for ii = 1:length(P_exp_2)
out = [out, P_pre_2(ii) - P_exp_2(ii)];
end
for ii = 1:length(P_exp_3)
out = [out, P_pre_3(ii) - P_exp_3(ii)];
end
for ii = 1:length(P_exp_4)
out = [out, P_pre_4(ii) - P_exp_4(ii)];
end
for ii = 1:length(P_exp_5)
out = [out, P_pre_5(ii) - P_exp_5(ii)];
end
end