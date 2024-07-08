% mu_neq and alpha_neq are parameter arrays with same length
% F is the 3x3 deformation gradient at one specific time
% be is the elastic left-Cauchy Green strain tensor at one specific time
% out is a 3x3 2nd PK stress tensor of none-equlibrium part at cooresponding time

function out = get_S_iso_neq(xi_neq, be, F)
out = inv(F) * get_tau_iso_neq(xi_neq, be) * inv(transpose(F));
end
% EOF