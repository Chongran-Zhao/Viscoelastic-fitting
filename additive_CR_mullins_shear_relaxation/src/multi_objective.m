function out = multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                Ft_2, P_exp_2, time_2,...
                                Ft_3, P_exp_3, time_3,...
                                Ft_4, P_exp_4, time_4,...
                                num_eq, num_neq)
[mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, m, r, beta] = paras_to_array(paras, num_eq, num_neq);
P_pre_1 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, m, r, beta, Ft_1, time_1);
P_pre_2 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, m, r, beta, Ft_2, time_2);
P_pre_3 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, m, r, beta, Ft_3, time_3);
P_pre_4 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, m, r, beta, Ft_4, time_4);

out = [];
for ii = 1:length(P_exp_1)
    out = [out, P_exp_1(ii) - P_pre_1(ii)];
end
for ii = 1:length(P_exp_2)
    out = [out, P_exp_2(ii) - P_pre_2(ii)];
end
for ii = 1:length(P_exp_3)
    out = [out, P_exp_3(ii) - P_pre_3(ii)];
end
for ii = 1:length(P_exp_4)
    out = [out, P_exp_4(ii) - P_pre_4(ii)];
end
end