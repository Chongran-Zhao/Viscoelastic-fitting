% mu_eq and alpha_eq are parameter arrays
% lambda is one scalar
% output is one scalar

function out = eq_dPsi_dlambda(mu_eq, alpha_eq, lambda)
if length(mu_eq) == length(alpha_eq)
    for ii = 1:length(mu_eq)
        out = mu_eq(ii) * lambda^( alpha_eq(ii)-1.0 );
    end
else
    error("ERROR: The length of mu and alpha of equilibrium part don't match!");
end
end
% EOF