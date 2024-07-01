function out = get_CR_eig_val(m, n, lambda)
out = ( lambda.^m - lambda.^(-n) ) ./ (m+n);
end