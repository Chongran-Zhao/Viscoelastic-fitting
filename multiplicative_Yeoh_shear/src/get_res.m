% eig_val_be, eig_val_eps, and eig_val_eps_trial are all 1x3 vectors,
% which are eigenvalues of be, epsilon and trial epsilon respectively
% mu_neq and alpha_neq are parameter arrays with same length
% dt is scalar incremental of loading time
% eta is scalar of one specific relaxation process
% out is the 1x3 residual vector
% refer to table 1 of Reese & Gocindjee 1998 IJSS

function out = get_res(eig_val_be, eig_val_eps, eig_val_eps_trial, xi_neq, dt, eta_d)
out = eig_val_eps + dt .* 0.5 ./ eta_d .* get_eig_val_tau_iso_neq(xi_neq, eig_val_be) - eig_val_eps_trial;
end
% EOF