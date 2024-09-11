function out = get_scale_der(m, n, lambda, order)
switch order
    case 0
        out = (lambda^m - lambda^(-n)) / (m+n);
    case 1
        out = m/(m+n) * lambda^(m-1) + n/(m+n) * lambda^(-n-1);
end
end