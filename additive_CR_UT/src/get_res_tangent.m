% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res_tangent(mu_neq, m_neq, n_neq, eta_d, C_mid, Gamma_old, Gamma_new, dt)
out = get_idn_4d();
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
Q_proj = get_proj_Q_neq(m_neq, n_neq, Gamma_mid);
T = get_T_neq(mu_neq, m_neq, n_neq, C_mid, Gamma_mid);
L_proj = get_proj_L(m_neq, n_neq, Gamma_mid);
K_proj = -2.0 .* mu_neq .* contract(transpose_4d(Q_proj), Q_proj) + contract(T, L_proj);
out = out - 0.5 .* dt .* K_proj ./ eta_d;
end