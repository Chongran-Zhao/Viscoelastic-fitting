% eig_val_be is the eigenvalues of be, as one 1x3 vector
% mu_neq and alpha_neq are parameter arrays with same length
% dt is scalar incremental of loading time
% eta is scalar of one specific relaxation process
% out is a 3x3 residual tangent matrix for local Newton iteration
% refer to eqn. B12 to B15 of Reese & Gocindjee 1998 IJSS

function out = get_res_tangent(eig_val_be, mu_neq, alpha_neq, dt, eta)
out = zeros(3,3);
coe1 = -2.0 / 9.0;
coe2 = 1.0 / 9.0;
coe3 = 4.0 / 9.0;
if length(mu_neq) == length(alpha_neq)
    for ii = 1:length(mu_neq)
        out(1,2) = out(1,2) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
        out(1,3) = out(1,3) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))));
        out(2,3) = out(2,3) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))));
        out(1,1) = out(1,1) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
        out(2,2) = out(2,2) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
        out(3,3) = out(3,3) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))));
    end
else
    disp(mu_neq);
    disp(alpha_neq);
    error("ERROR: The length of mu and alpha of none-equilibrium part don't match!")
end
out = (0.5 .* dt ./ eta) .* out;
out(2,1) = out(1,2);
out(3,1) = out(1,3);
out(3,2) = out(2,3);
out(1,1) = out(1,1) + 1.0;
out(2,2) = out(2,2) + 1.0;
out(3,3) = out(3,3) + 1.0;
end
% EOF