function out = objective(paras, Ft, P_shear_exp, time, num_eq, num_neq)
[xi_eq, xi_neq, eta_d] = paras_to_array(paras, num_eq, num_neq);
P_shear_list = get_P_ij_list(1, 2, xi_eq, xi_neq, eta_d, Ft, time);
out = [];
for ii = 1:length(time)
    out = [out, P_shear_list(ii) - P_shear_exp(ii)];
end
end