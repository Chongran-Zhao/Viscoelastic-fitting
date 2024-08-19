function out = get_P_iso_list(xi_eq, xi_neq, C1, C2, tau_hat, power_m, Ft, time)
out = get_P_iso_eq_list(xi_eq, Ft);
for ii = 1:2
    be_t = get_be_t(time, xi_neq(ii,:), C1(ii), C2(ii), tau_hat(ii), power_m(ii), Ft);
    out = out + get_P_iso_neq_list(xi_neq(ii,:), be_t, Ft);
end
end