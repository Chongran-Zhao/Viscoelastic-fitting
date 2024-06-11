function out = get_SH_scale_der2(m, lambda)
if m == 0
    out = -1.0 / (lambda*lambda);
else
    out = (m-1.0) * lambda^(m-2.0);
end
end