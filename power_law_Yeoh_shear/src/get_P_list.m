% This function is aimed at calculating the total 1st PK stress of
% multi-relaxation process during total loading time
% eta_list is one array containing parameters determining different
% relaxation process

function out = get_P_list(xi_eq, xi_neq, eta_d, Ft, time)
out = get_P_iso_list(xi_eq, xi_neq, eta_d, Ft, time);
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    F = Ft(:,:,ii);
    inv_F_transpose = inv(F');
    p = out(3,3,ii) / inv_F_transpose(3,3);
    out(:,:,ii) = out(:,:,ii) - p .* inv_F_transpose;
end
end
% EOF