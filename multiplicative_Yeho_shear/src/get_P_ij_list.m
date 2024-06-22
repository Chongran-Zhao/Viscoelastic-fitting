function out = get_P_ij_list(ii, jj, xi_eq, xi_neq, eta_list, Ft, time)
out = zeros(length(time), 1);
P_list = get_P_list(xi_eq, xi_neq, eta_list, Ft, time);
out(:) = P_list(ii,jj,:);
end