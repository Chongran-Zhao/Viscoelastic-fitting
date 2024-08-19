% The function is to obtain the isochoric 1st PK stress tensor during the
% total loading time
% mu_eq and alpha_eq are parameter arrays with same length
% Ft is the deformation gradient array of total loading case with size of (3, 3, length of data)
% out is the same size of Ft

function out = get_P_iso_eq_list(xi_eq, Ft)
out = zeros(size(Ft));
for ii = 1:size(Ft, 3)
    out(:,:,ii) = get_P_iso_eq(xi_eq, Ft(:,:,ii));
end
end
% EOF