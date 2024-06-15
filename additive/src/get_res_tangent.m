% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res_tangent(mu, m, n, eta_d, C_mid, Gamma_old, Gamma_new, dt)
out = get_sym_idn_4d();
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
Q_proj_v = get_proj_Q_v(m, n, Gamma_mid);
T = get_T(mu, m, n, C_mid) - get_T(mu, m, n, Gamma_mid);
L_proj = get_proj_L(m, n, Gamma_mid);
K_proj = -2.0 .* mu .* contract(transpose_4d(Q_proj_v), Q_proj_v) + contract(T, L_proj);
out = out - 0.5 .* dt .* K_proj ./ eta_d;
end