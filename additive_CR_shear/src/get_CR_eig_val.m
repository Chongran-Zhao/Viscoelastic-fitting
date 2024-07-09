function out = get_CR_eig_val(m, n, lambda)
out = zeros(3,1);
for ii = 1:length(lambda)
    out(ii) = (lambda(ii)^m - lambda(ii)^n) / (m+n);
end
end