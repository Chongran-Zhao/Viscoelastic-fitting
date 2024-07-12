function out = multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                      Ft_2, P_exp_2, time_2,...
                                      Ft_3, P_exp_3, time_3)
[xi_eq, xi_neq, tau_hat, power_m] = paras_to_array(paras);
P_pre_1 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_1, time_1);
P_pre_2 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_2, time_2);
P_pre_3 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_3, time_3);

out = 0.0;
for ii = 1:length(time_1)
    out = [out, (P_pre_1(ii) - P_exp_1(ii))];
end
for ii = 1:length(time_2)
    out = [out, (P_pre_2(ii) - P_exp_2(ii))];
end
for ii = 1:length(time_3)
    out = [out, (P_pre_3(ii) - P_exp_3(ii))];
end
end