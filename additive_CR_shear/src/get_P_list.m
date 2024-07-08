function out = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, Ft, time)
out = zeros(size(Ft));
for ii = 1:length(mu_eq)
    out = out + get_P_iso_eq_list(mu_eq(ii), m_eq(ii), n_eq(ii), Ft);
end
for ii = 1:length(eta)
    out = out + get_P_iso_neq_list(mu_neq(ii), m_neq(ii), n_neq(ii), eta(ii), Ft, time);
end
sigma = zeros(size(out));
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    sigma(:,:,ii) = out(:,:,ii) * transpose(Ft(:,:,ii));
    sigma(:,:,ii) = sigma(:,:,ii) - sigma(3,3,ii) .* eye(3);
    out(:,:,ii) = sigma(:,:,ii) * inv(transpose(Ft(:,:,ii)));
end
end
% EOF