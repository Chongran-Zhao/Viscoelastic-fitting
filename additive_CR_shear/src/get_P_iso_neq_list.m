function out = get_P_iso_neq_list(mu_neq_list, m_neq_list, n_neq_list, eta_d_list, Ft, time)
out = zeros(size(Ft));
for ii = 1:length(mu_neq_list)
    Gamma_t = get_Gamma_t(mu_neq_list(ii), m_neq_list(ii), n_neq_list(ii), eta_d_list(ii), Ft, time);
    for jj = 1:length(time)
        out(:,:,jj) = out(:,:,jj) + get_P_iso_neq(mu_neq_list(ii), m_neq_list(ii), n_neq_list(ii), Ft(:,:,jj), Gamma_t(:,:,jj));
    end
end
end
% EOF