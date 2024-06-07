function out = get_CR_eig_val(m, n, lambda)
out = m .* get_SH_eig_val(m, lambda) ./ (m+n) + n .* get_SH_eig_val(-n, lambda) ./ (m+n);
end