% refer to Local Newton-Raphson iteration box of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_res(mu_neq, m_neq, n_neq, eta_d, F_mid, Gamma_old, Gamma_new, dt)
Gamma_mid = 0.5 .* (Gamma_old + Gamma_new);
Q = contract(get_T_neq(mu_neq, m_neq, n_neq, F_mid, Gamma_mid), get_proj_Q_neq(m_neq, n_neq, Gamma_mid));
out = Gamma_new - Gamma_old - dt .* Q ./ eta_d;
end