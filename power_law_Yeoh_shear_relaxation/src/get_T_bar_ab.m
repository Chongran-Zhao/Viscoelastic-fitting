function out = get_T_bar_ab(xi, be1, be2, be3)
T_ab = get_T_ab(xi, be1, be2, be3);
out = T_ab - get_trace(T_ab) / 3.0 .* eye(3);
end