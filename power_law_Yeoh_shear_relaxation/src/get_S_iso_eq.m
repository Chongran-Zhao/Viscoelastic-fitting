function out = get_S_iso_eq(xi_eq, F)
proj_P = get_proj_P(F);
F_bar = F .* det(F)^(1.0/3.0);
S_bar_eq = get_S_bar_eq(xi_eq, F_bar);
out = contract(proj_P, S_bar_eq);
out = det(F)^(-2.0/3.0) .* out;
end
% EOF