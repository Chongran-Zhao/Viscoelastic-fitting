% The function is to obtain the isochoric 1st PK stress tensor of
% non-equilibrium partduring the total loading time
% mu_neq and alpha_neq are parameter arrays with same length
% Ft is the deformation gradient array of total loading case with size of (3, 3, length of data)
% be_t is the strain tensor array of total loading case with size of (3, 3, length of data)
% out is the same size of Ft

function out = get_P_iso_neq_list(xi_neq, be_t, Ft)
out = zeros(size(Ft));
for ii=1:size(Ft, 3)
out(:,:,ii) = get_P_iso_neq(xi_neq, be_t(:,:,ii), Ft(:,:,ii));
end
end
% EOF