function out = get_eta_d(mu_neq, m_neq, n_neq, p, alpha, C, Ev)
out = 10.0^p;
T_neq = get_T_neq(mu_neq, m_neq, n_neq, C, Ev);
out = out * (get_norm(T_neq)+1.0)^alpha;
end