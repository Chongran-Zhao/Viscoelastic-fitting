function out = get_CR_eig_val_der(m, n, lambda, order)
switch order
    case 1
        out = (m/(m+n)) .* lambda.^(m-1.0) + (n/(m+n)) .* lambda.^(-n-1.0);
    case 2
        out = (m*m/(m+n)) .* lambda.^(m-2.0) - (n*n/(m+n)) .* lambda.^(-n-2.0);
end
end