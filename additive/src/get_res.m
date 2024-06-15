% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res(mu, m, n, eta_d, C_mid, Gamma_old, Gamma_new, dt)
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
get_T(mu, m, n, C_mid)
get_T(mu, m, n, Gamma_mid)
Q = contract(get_T(mu, m, n, C_mid) - get_T(mu, m, n, Gamma_mid), get_proj_Q_v(m, n, Gamma_mid));
out = Gamma_new - Gamma_old - 0.5 .* dt .* Q ./ eta_d;
end