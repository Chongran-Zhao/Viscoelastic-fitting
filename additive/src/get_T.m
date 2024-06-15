% The function is used to obtain the stress-like tensor T,
% which is conjugated with generalized strain E
% refer to sec. 2.3 of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_T(mu, m, n, C)
out = 2.* mu .* get_CR_strain(m, n, C);
end