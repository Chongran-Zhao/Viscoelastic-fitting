function out = get_CR_eig_val_der(m, n, lambda, order)
out = zeros(3,1);
switch order
    case 1
        for ii = 1:3
            out(ii) = m/(m+n) * lambda(ii)^(m-1) + n/(m+n) * lambda(ii)^(-n-1);
        end
    case 2
        for ii = 1:3
            out(ii) = (m-1)*m/(m+n) * lambda(ii)^(m-2) - (n+1)*n/(m+n) * lambda(ii)^(-n-2);
        end
end
end