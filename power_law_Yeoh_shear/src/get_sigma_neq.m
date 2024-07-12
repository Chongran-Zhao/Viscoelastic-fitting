function out = get_sigma_neq(xi_neq, Fe, F)
out = get_S_iso_neq(xi_neq, Fe, F);
out = F * out * F';
end