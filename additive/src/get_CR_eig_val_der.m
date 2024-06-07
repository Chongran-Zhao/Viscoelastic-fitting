function out = get_CR_eig_val_der(m, n, lambda)
out = m .* get_SH_eig_val_der(m, lambda) ./ (m+n) + n .* get_SH_eig_val_der(-n, lambda) ./ (m+n);
end