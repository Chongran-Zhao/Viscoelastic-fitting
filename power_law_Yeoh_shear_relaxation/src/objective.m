function out = objective(paras, Ft, P_shear_exp, time)
[xi_eq, xi_neq, C1, C2, tau_hat, power_m] = paras_to_array(paras);
P_shear_list = get_P_ij_list(1, 2, xi_eq, xi_neq, C1, C2, tau_hat, power_m, Ft, time);
out = [];
for ii = 1:length(time)
    out = [out, P_shear_list(ii) - P_shear_exp(ii)];
end
end