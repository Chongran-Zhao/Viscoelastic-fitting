% This function is aimed at calculating the total 1st PK stress of
% multi-relaxation process during total loading time
% eta_list is one array containing parameters determining different
% relaxation process

function out = get_P_list(mu_eq, alpha_eq, mu_neq_list, alpha_neq_list, eta_list, Ft, time)
out = get_P_iso_list(mu_eq, alpha_eq, mu_neq_list, alpha_neq_list, eta_list, Ft, time);
sigma = zeros(size(out));
% determine the pressure through incompressbility constrain
for ii = 1:length(time)
    sigma(:,:,ii) = out(:,:,ii) * transpose(Ft(:,:,ii));

    sigma(:,:,ii) = sigma(:,:,ii) - sigma(3,3,ii) .* ones(3,3);
    out(:,:,ii) = sigma(:,:,ii) * inv(transpose(Ft(:,:,ii)));
end
end
% EOF