function out = get_viscosity_4d_inv(eta_d)
out = zeros(3,3,3,3);
convert_4d_to_2d(get_viscosity_4d(eta_d))
out = convert_2d_to_4d(inv(convert_4d_to_2d(get_viscosity_4d(eta_d))));
end