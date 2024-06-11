% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res(mu, m, n, eta_d, Gamma_old, Gamma_new, F_old, F_new, dt)
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
F_mid = 0.5 .* (F_old + F_new);
Q = contract(get_T(mu, m, n, F_mid), get_proj_Q_v(m, n, Gamma_mid));
out = Gamma_new - Gamma_old - dt .* contract(get_viscosity_4d(eta_d), Q);
end