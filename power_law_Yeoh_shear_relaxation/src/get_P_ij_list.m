function out = get_P_ij_list(ii, jj, xi_eq, xi_neq, C1, C2, tau_hat, power_m, Ft, time)
out = zeros(length(time), 1);
P_pre = get_P_list(xi_eq, xi_neq, C1, C2, tau_hat, power_m, Ft, time);
out(:) = P_pre(ii,jj,:);
end