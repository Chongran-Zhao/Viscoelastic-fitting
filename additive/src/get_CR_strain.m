function out = get_CR_strain(m, n, F)
out = m .* get_SH_strain(m, F) ./ (m+n)...
    + n .* get_SH_strain(-n,F) ./ (m+n);
end