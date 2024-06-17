% This function is to extract the first principal value of total 1st PK
% stress tensor during the total loading time

function out = get_P1_list(xi_eq, xi_neq, eta_d, Ft, time)
out = zeros(1, length(time));
P_list = get_P_list(xi_eq, xi_neq, eta_d, Ft, time);
out(:) = P_list(1,1,:);
end
% EOF