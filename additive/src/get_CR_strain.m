function out = get_CR_strain(m, n, C)
out = m .* get_SH_strain(m, C) ./ (m+n)...
    + n .* get_SH_strain(-n,C) ./ (m+n);
end