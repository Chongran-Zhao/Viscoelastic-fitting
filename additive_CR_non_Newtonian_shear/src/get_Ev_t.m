function out = get_Ev_t(mu_neq, m_neq, n_neq, p, alpha, Ft, time)
out = zeros(size(Ft));
% Forward Euler
% for ii = 1:length(time)
%     if ii == 1
%         dt = time(1);
%         Ev_old = zeros(3,3);
%         C_old = eye(3);
%     else
%         dt = time(ii) - time(ii-1);
%         Ev_old = out(:,:,ii-1);
%         F_old = Ft(:,:,ii-1);
%         C_old = F_old' * F_old;
%     end
%     eta_d = get_eta_d(mu_neq, m_neq, n_neq, p, alpha, C_old, Ev_old);
%     E_old = get_CR_strain(m_neq, n_neq, C_old);
%     out(:,:,ii) = mu_neq / eta_d * dt .* (E_old - Ev_old) + Ev_old;
% end

% Modified Euler
for ii = 1:length(time)
    if ii == 1
        dt = time(1);
        Ev_old = zeros(3,3);
        C_old = eye(3);
    else
        dt = time(ii) - time(ii-1);
        Ev_old = out(:,:,ii-1);
        F_old = Ft(:,:,ii-1);
        C_old = F_old' * F_old;
    end
    C_new = Ft(:,:,ii)' * Ft(:,:,ii);
    E_new = get_CR_strain(m_neq, n_neq, C_new);
    eta_d = get_eta_d(mu_neq, m_neq, n_neq, p, alpha, C_old, Ev_old);
    out(:,:,ii) = (mu_neq * dt / (eta_d + mu_neq * dt)) .* E_new;
    out(:,:,ii) = out(:,:,ii) + (eta_d / (eta_d + mu_neq * dt)) .* Ev_old;
end

% Exponential integral + Forward Euler
% for ii = 1:length(time)
%     if ii == 1
%         dt = time(1);
%         C_old = eye(3);
%         Ev_old = zeros(3,3);
%     else
%         dt = time(ii) - time(ii-1);
%         F_old = Ft(:,:,ii-1);
%         C_old = F_old' * F_old;
%         Ev_old = out(:,:,ii-1);
%     end
%     eta_d = get_eta_d(mu_neq, m_neq, n_neq, p, alpha, C_old, Ev_old);
%     E_old = get_CR_strain(m_neq, n_neq, C_old);
%     out(:,:,ii) = exp(-mu_neq*dt/eta_d) .* Ev_old + exp(-mu_neq*dt/eta_d) * mu_neq / eta_d * dt .* E_old;
% end
end