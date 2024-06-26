% This function is aimed at calculating the isochoric 1st PK stress of
% multi-relaxation process during total loading time
% eta_list is one array containing parameters determining different
% relaxation process

function out = get_P_iso_list(mu_eq, alpha_eq, mu_neq_list, alpha_neq_list, eta_list, Ft, time)
P_iso_eq_list = get_P_iso_eq_list(mu_eq, alpha_eq, Ft);
P_iso_neq_list_multi_relax = zeros(3, 3, size(Ft,3), length(eta_list));
out = P_iso_eq_list;
for ii = 1:length(eta_list)
    be_t = get_be_t(time, mu_neq_list(:,ii), alpha_neq_list(:,ii), eta_list(ii), Ft);
    P_iso_neq_list_multi_relax(:,:,:,ii) = get_P_iso_neq_list(mu_neq_list(:,ii), alpha_neq_list(:,ii), Ft, be_t);
    out = out + P_iso_neq_list_multi_relax(:,:,:,ii);
end
end
% EOF