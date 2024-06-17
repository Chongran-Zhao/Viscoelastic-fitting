% The function is used to solve the pressure p based
% on the incompressibility constrain of each time step
% both xi_eq and xi_neq are 6x1 arrays
% Ft is size of (3, 3, length of data)
% be is size of (3, 3, length of data)
% out is a array with length of data
function out = solve_p_list(xi_eq, xi_neq, Ft, be_t)
out = zeros(size(Ft, 3), 1);
for ii=1:length(out)
    F_inv_transpose = inv(transpose(Ft(:,:,ii)));
    P_eq = get_P_iso_eq(xi_eq, Ft(:,:,ii));
    P_neq = get_P_iso_neq(xi_neq, Ft(:,:,ii), be_t(:,:,ii));
    out(ii) = (P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2);
    if abs((P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2) - (P_eq(3,3) + P_neq(3,3)) / F_inv_transpose(3,3)) < 1e-10
        out(ii) = (P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2);
    else
        format long
        disp((P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2));
        disp((P_eq(3,3) + P_neq(3,3)) / F_inv_transpose(3,3));
        error("ERROR: solve_p_list is wrong!");
    end
end
end