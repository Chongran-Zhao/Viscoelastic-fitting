% mu_neq and alpha_neq are parameter arrays with same length
% eig_val_be should be one 1x3 vector
% out is the eigenvalue set of isochoric Kirchhoff stress tensor, which is one 1x3 vector
% refer to eqn. B8 of Reese & Gocindjee 1998 IJSS

function out = get_eig_val_tau_iso_neq(xi_neq, eig_val_be)
out = zeros(3,1);
coe1 = 4.0 / 3.0;
coe2 = -2.0 / 3.0;
I1 = eig_val_be(1) + eig_val_be(2) + eig_val_be(3);
alpha = xi_neq(1) + 2.0*xi_neq(2)*(I1-3.0) + 3.0*xi_neq(3)*(I1-3.0)^2;
out(1) = coe1 * eig_val_be(1) + coe2 * eig_val_be(2) + coe2 * eig_val_be(3);
out(2) = coe1 * eig_val_be(2) + coe2 * eig_val_be(1) + coe2 * eig_val_be(3);
out(3) = coe1 * eig_val_be(3) + coe2 * eig_val_be(1) + coe2 * eig_val_be(2);
out = out .* alpha;
end
% EOF