function out = get_N(xi_neq, be)
tau_iso_neq = get_tau_iso_neq(xi_neq, be);
out = tau_iso_neq ./ get_norm(tau_iso_neq);
end