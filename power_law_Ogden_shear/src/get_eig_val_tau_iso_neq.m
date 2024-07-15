% mu_neq and alpha_neq are parameter arrays with same length
% eig_val_be should be one 1x3 vector
% out is the eigenvalue set of isochoric Kirchhoff stress tensor, which is one 1x3 vector
% refer to eqn. B8 of Reese & Gocindjee 1998 IJSS

function out = get_eig_val_tau_iso_neq(mu_neq, alpha_neq, eig_val_be)
out = zeros(3,1);
coe1 = 2.0 / 3.0;
coe2 = -1.0 / 3.0;
if length(mu_neq) == length(alpha_neq)
    for ii = 1:length(mu_neq)
        out(1) = out(1) + mu_neq(ii)*(coe1*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
        out(2) = out(2) + mu_neq(ii)*(coe1*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
        out(3) = out(3) + mu_neq(ii)*(coe1*eig_val_be(3)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)));
    end
else
    error("ERROR: The length of mu and alpha of none-equilibrium part don't match!")
end
end
% EOF