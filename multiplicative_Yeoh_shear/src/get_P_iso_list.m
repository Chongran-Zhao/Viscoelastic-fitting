function out = get_P_iso_list(xi_eq, xi_neq, eta, Ft, time)
be_t = get_be_t(time, xi_neq, eta, Ft);
out = get_P_iso_eq_list(xi_eq, Ft) + get_P_iso_neq_list(xi_neq, Ft, be_t);
end