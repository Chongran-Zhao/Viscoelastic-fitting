% mu_neq and alpha_neq are parameter arrays
% lambda is one scalar
% output is one scalar

function out = neq_dPsi_dlambda(mu_neq, alpha_neq, lambda)
if length(mu_neq) == length(alpha_neq)
    for ii = 1:length(mu_neq)
        out = mu_neq(ii) * lambda^( alpha_neq(ii)-1.0 );
    end
else
    error("ERROR: The length of mu and alpha of none-equilibrium part don't match!");
end
end
% EOF