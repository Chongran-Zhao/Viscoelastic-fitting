function out = get_P_list(mu_eq_list, m_eq_list, n_eq_list, mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time)
out = get_P_iso_eq_list(mu_eq_list, m_eq_list, n_eq_list, Ft) + get_P_iso_neq_list(mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time);
sigma = zeros(size(out));
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    sigma(:,:,ii) = out(:,:,ii) * transpose(Ft(:,:,ii));
    sigma(:,:,ii) = sigma(:,:,ii) - sigma(3,3,ii) .* eye(3);
    out(:,:,ii) = sigma(:,:,ii) * inv(transpose(Ft(:,:,ii)));
end
end
% EOF