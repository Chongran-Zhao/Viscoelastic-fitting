function out = get_viscosity_4d(eta_d)
out = 2.0 .* eta_d .* (get_sym_idn_4d() - cross_otimes_2d_to_4d(eye(3), eye(3)) ./ 3.0);
end