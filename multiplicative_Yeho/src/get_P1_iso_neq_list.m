% The function is used to extract the first pricipal value of non-
% equilibrium part of first PK stress during total time loading case
% mu_neq and alpha_neq are parameter arrays with same length
% Ft is the deformation gradient array of total loading case with size of (3, 3, length of data)
% be is the elastic left-Cauchy Green strain tensor list during total loading case
% out is one array containing the first pricipal value of non-equilibrium first PK stress during total loading time

function out = get_P1_iso_neq_list(xi_neq, Ft, be_t)
out = zeros(size(Ft, 3), 1);
P_iso_neq_list = get_P_iso_neq_list(xi_neq, Ft, be_t);
for ii = 1:length(out)
    out(ii) = P_iso_neq_list(1, 1, ii);
end
end
% EOF