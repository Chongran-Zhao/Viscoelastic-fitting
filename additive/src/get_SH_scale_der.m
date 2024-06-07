function out = get_SH_scale_der(m, lambda)
if m == 0
    out = 1.0 / lambda;
else
    out = lambda^(m-1.0);
end
end