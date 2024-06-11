function out = get_CR_eig_val_der2(m, n, lambda)
out = m .* get_SH_eig_val_der2(m, lambda) ./ (m+n) + n .* get_SH_eig_val_der2(-n, lambda) ./ (m+n);
end