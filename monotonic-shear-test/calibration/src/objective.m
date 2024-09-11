function out = objective(paras, Ft_1, P_exp_1, time_1,...
                                Ft_2, P_exp_2, time_2,...
                                Ft_3, P_exp_3, time_3,...
                                num_eq, num_neq)
[mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta] = paras_to_array(paras, num_eq, num_neq);
P_fit_1 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, Ft_1, time_1);
P_fit_2 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, Ft_2, time_2);
P_fit_3 = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, Ft_3, time_3);

out = [];
for ii = 1:length(P_exp_1)
    out = [out, P_exp_1(ii) - P_fit_1(ii)];
end
for ii = 1:length(P_exp_2)
    out = [out, P_exp_2(ii) - P_fit_2(ii)];
end
for ii = 1:length(P_exp_3)
    out = [out, P_exp_3(ii) - P_fit_3(ii)];
end
end