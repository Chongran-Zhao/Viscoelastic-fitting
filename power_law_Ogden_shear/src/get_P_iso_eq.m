% This function is to obtain the isochoric 1st PK stress tensor of equilibrium part
% through isochoric 2nd PK stress tensor at one specific time
% mu_eq and alpha_eq are parameter arrays with same length
% F is one 3x3 deformation gradient at specific time

function out = get_P_iso_eq(mu_eq, alpha_eq, F)
out = F * get_S_iso_eq(mu_eq, alpha_eq, F);
end
% EOF