function out = get_S(mu, m, n, F)
out = contract(get_T(mu, m, n, F), get_proj_Q(m, n, F));
end