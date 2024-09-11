function out = get_P_list(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta, F_list, time)
out = zeros(size(F_list));
Ev_list = get_Ev_list(mu_neq, m_neq, n_neq, eta, F_list, time);
for ii = 1:length(time)
    out(:,:,ii) = get_S_iso_eq(mu_eq, m_eq, n_eq, F_list(:,:,ii));
    out(:,:,ii) = out(:,:,ii) + get_S_iso_neq(mu_neq, m_neq, n_eq, F_list(:,:,ii), Ev_list(:,:,ii));
    out(:,:,ii) = F_list(:,:,ii) * out(:,:,ii);
    out(:,:,ii) = incompressible_constraint(out(:,:,ii), F_list(:,:,ii));
end
end