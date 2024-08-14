function out = get_BI_scale_der(m, lambda, order)
switch order
    case 1
        out = 0.5 * lambda^(m-1) + 0.5 * lambda^(-m-1);
    case 2
        out = (m-1)* 0.5 * lambda^(m-2) - (m+1) * 0.5 * lambda^(-m-2);
end
end