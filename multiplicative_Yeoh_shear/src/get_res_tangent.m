% eig_val_be is the eigenvalues of be, as one 1x3 vector
% mu_neq and alpha_neq are parameter arrays with same length
% dt is scalar incremental of loading time
% eta is scalar of one specific relaxation process
% out is a 3x3 residual tangent matrix for local Newton iteration
% refer to eqn. B12 to B15 of Reese & Gocindjee 1998 IJSS

function out = get_res_tangent(eig_val_be, xi_neq, dt, eta_d)
out = zeros(3,3);
coe1 = 16.0 / 9.0;
coe2 = -8.0 / 9.0;
coe3 = 4.0 / 9.0;
I1 = eig_val_be(1) + eig_val_be(2) + eig_val_be(3);
alpha = xi_neq(1) + 2.0*xi_neq(2)*(I1-3.0) + 3.0*xi_neq(3)*(I1-3.0)^2;
out(1,1) = coe1 * eig_val_be(1) + coe2 * eig_val_be(2) + coe2 * eig_val_be(3);
out(2,2) = coe1 * eig_val_be(2) + coe2 * eig_val_be(1) + coe2 * eig_val_be(3);
out(3,3) = coe1 * eig_val_be(3) + coe2 * eig_val_be(1) + coe2 * eig_val_be(2);
out(1,2) = coe2 * eig_val_be(1) + coe2 * eig_val_be(2) + coe3 * eig_val_be(3);
out(1,3) = coe2 * eig_val_be(1) + coe2 * eig_val_be(3) + coe3 * eig_val_be(2);
out(2,3) = coe2 * eig_val_be(2) + coe2 * eig_val_be(3) + coe3 * eig_val_be(1);

out(2,1) = out(1,2);
out(3,1) = out(1,3);
out(3,2) = out(2,3);
out = (0.5 .* dt ./ eta_d) * alpha .* out;
out(1,1) = out(1,1) + 1.0;
out(2,2) = out(2,2) + 1.0;
out(3,3) = out(3,3) + 1.0;
end
% EOF