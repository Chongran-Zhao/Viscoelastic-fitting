% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res_tangent(mu, m, n, eta_d, Gamma_old, Gamma_new, F_old, F_new, dt)
out = get_sym_idn_4d();
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
F_mid = 0.5 .* (F_old + F_new);
Q_proj_v = get_proj_Q_v(m, n, Gamma_mid);
T = get_T(mu, m, n, F_mid);
L_proj = get_proj_L(m, n, F_mid);
K_proj = -2.0 .* mu .* contract(transpose_4d(Q_proj_v), Q_proj_v) + contract(T, L_proj);
out = out - 0.5 .* dt .* contract(get_viscosity_4d(eta_d), K_proj);
end