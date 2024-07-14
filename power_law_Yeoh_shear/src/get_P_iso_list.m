function out = get_P_iso_list(xi_eq, xi_neq, tau_hat, power_m, Ft, time)
be_t = get_be_t(time, xi_neq, tau_hat, power_m, Ft);
out = get_P_iso_eq_list(xi_eq, Ft) + get_P_iso_neq_list(xi_neq, be_t, Ft);
end