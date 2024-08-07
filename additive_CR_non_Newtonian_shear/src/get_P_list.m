function out = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, p, alpha, Ft, time)
out = zeros(size(Ft));
for ii = 1:length(mu_eq)
    out = out + get_P_iso_eq_list(mu_eq(ii), m_eq(ii), n_eq(ii), Ft);
end
for ii = 1:length(p)
    out = out + get_P_iso_neq_list(mu_neq(ii), m_neq(ii), n_neq(ii), p, alpha, Ft, time);
end
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    F = Ft(:,:,ii);
    inv_F_transpose = inv(F');
    p = out(3,3,ii) / inv_F_transpose(3,3);
    out(:,:,ii) = out(:,:,ii) - p .* inv_F_transpose;
end
end
% EOF