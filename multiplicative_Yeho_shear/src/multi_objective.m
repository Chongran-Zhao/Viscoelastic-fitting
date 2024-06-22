function out = multi_objective(paras, Ft_1, P_exp_1, time_1,...
                             Ft_2, P_exp_2, time_2,...
                             Ft_3, P_exp_3, time_3,...
                             num_eq, num_neq)
[xi_eq, xi_neq, eta_d] = paras_to_array(paras, num_eq, num_neq);
P_shear_list_1 = get_P_ij_list(1, 2, xi_eq, xi_neq, eta_d, Ft_1, time_1);
P_shear_list_2 = get_P_ij_list(1, 2, xi_eq, xi_neq, eta_d, Ft_2, time_2);
P_shear_list_3 = get_P_ij_list(1, 2, xi_eq, xi_neq, eta_d, Ft_3, time_3);

out = 0.0;
for ii = 1:length(time_1)
    out = [out, (P_shear_list_1(ii) - P_exp_1(ii))];
end
for ii = 1:length(time_2)
    out = [out, (P_shear_list_2(ii) - P_exp_2(ii))];
end
for ii = 1:length(time_3)
    out = [out, (P_shear_list_3(ii) - P_exp_3(ii))];
end
end