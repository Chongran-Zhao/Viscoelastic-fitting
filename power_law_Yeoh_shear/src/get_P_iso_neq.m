% This function is to obtain the isochoric 1st PK stress tensor of non-equilibrium
% part through isochoric 2nd PK stress tensor at one specific time
% mu_neq and alpha_neq are parameter arrays with same length
% F is one 3x3 deformation gradient at specific time
% be is one 3x3 strain tensor at specific time

function out = get_P_iso_neq(xi_neq, Fe, F)
out = F * get_S_iso_neq(xi_neq, Fe, F);
end
% EOF