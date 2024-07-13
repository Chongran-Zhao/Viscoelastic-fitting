function out = get_Ev_t(mu_neq, m_neq, n_neq, eta_d, Ft, time)
out = zeros(size(Ft));
for ii = 1:length(time)
    if ii == 1
        dt = time(1);
    else
        dt = time(ii) - time(ii-1);
    end
    C_new = Ft(:,:,ii)' * Ft(:,:,ii);
    E_new = get_CR_strain(m_neq, n_neq, C_new);
    out(:,:,ii) = (mu_neq * dt / (eta_d + mu_neq * dt)) .* E_new;
    if ii == 1
        out(:,:,ii) = out(:,:,ii) + (eta_d / (eta_d + mu_neq * dt)) .* zeros(3,3);
    else
        out(:,:,ii) = out(:,:,ii) + (eta_d / (eta_d + mu_neq * dt)) .* out(:,:,ii-1);
    end
end
end