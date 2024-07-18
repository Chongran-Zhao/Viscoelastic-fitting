function out = get_P_ij_list(ii, jj, xi_eq, xi_neq, tau_hat, power_m, Ft, time)
out = zeros(length(time), 1);
P_pre = get_P_iso_list(xi_eq, xi_neq, tau_hat, power_m, Ft, time);
out(:) = P_pre(ii,jj,:);
end