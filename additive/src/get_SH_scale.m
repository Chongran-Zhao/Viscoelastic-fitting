function out = get_SH_scale(m, lambda)
if m == 0
    out = log(lambda);
else
    out = (lambda^m - 1);
end
end