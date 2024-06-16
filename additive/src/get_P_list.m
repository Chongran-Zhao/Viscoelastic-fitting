function out = get_P_list(mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time)
out = get_P_iso_eq_list(mu_eq_list, m_eq_list, n_eq_list, Ft) + get_P_iso_neq_list(mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time);
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    F_inv_transpose = inv(transpose(Ft(:,:,ii)));
    p = out(2,2,ii) / F_inv_transpose(2,2);
    out(:,:,ii) = out(:,:,ii) - p.*F_inv_transpose;
end
end
% EOF