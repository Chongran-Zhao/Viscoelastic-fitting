% This function is aimed at calculating the total 1st PK stress of
% multi-relaxation process during total loading time
% eta_list is one array containing parameters determining different
% relaxation process

function out = get_P_list(xi_eq, xi_neq, eta_d, Ft, time)
P_iso_eq_list = get_P_iso_eq_list(xi_eq, Ft);
out = P_iso_eq_list;
    be_t = get_be_t(time, xi_neq, eta_d, Ft);
    P_iso_neq_list = get_P_iso_neq_list(xi_neq, Ft, be_t);
    out = out + P_iso_neq_list;
% determine the pressure through incompressbility constrain
% for ii = 1:length(time)
%     F_inv_transpose = inv(transpose(Ft(:,:,ii)));
%     p = out(2,2,ii) / F_inv_transpose(2,2);
%     out(:,:,ii) = out(:,:,ii) - p.*F_inv_transpose;
% end
end
% EOF