function out = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, p, alpha, Ft, time)
out = get_P_iso_eq_list(mu_eq, m_eq, n_eq, Ft);
out = out + get_P_iso_neq_list(mu_neq, m_neq, n_neq, p, alpha, Ft, time);
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    F = Ft(:,:,ii);
    inv_F_transpose = inv(F');
    pres = out(3,3,ii) / inv_F_transpose(3,3);
    out(:,:,ii) = out(:,:,ii) - pres .* inv_F_transpose;
end
end
% EOF