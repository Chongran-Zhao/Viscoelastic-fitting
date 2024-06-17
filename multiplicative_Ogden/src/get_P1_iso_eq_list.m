% The function is used to extract the first pricipal
% value of equilibrium part of first PK stress during total loading time
% mu_eq and alpha_eq are parameter arrays
% Ft is the deformation gradient array of total loading case with size of (3, 3, length of data)
% out is one array containing the first pricipal value of equilibrium first PK stress during total loading time

function out = get_P1_iso_eq_list(mu_eq, alpha_eq, Ft)
out = zeros(size(Ft, 3), 1);
P_iso_eq_list = get_P_iso_eq_list(mu_eq, alpha_eq, Ft);
for ii = 1:length(out)
    out(ii) = P_iso_eq_list(1, 1, ii);
end
end
% EOF