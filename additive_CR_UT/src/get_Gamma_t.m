function out = get_Gamma_t(mu_neq, m_neq, n_neq, eta_d, Ft, time)
out = zeros(3,3,length(time));
for ii = 1:length(time)
    % error = 1.0;
    % counter = 0;
    % if ii == 1
    %     C_old = eye(3);
    %     C_new = Ft(:,:,ii)' * Ft(:,:,ii);
    %     C_mid = 0.5 .* (C_old + C_new);
    %     Gamma_old = eye(3);
    %     Gamma_new = eye(3);
    %     dt = time(ii);
    % else
    %     C_old = Ft(:,:,ii-1)' * Ft(:,:,ii-1);
    %     C_new = Ft(:,:,ii)' * Ft(:,:,ii);
    %     C_mid = 0.5 .* (C_old + C_new);
    %     Gamma_old = out(:,:,ii-1);
    %     Gamma_new = Gamma_old;
    %     dt = time(ii) - time(ii-1);
    % end
    % while error > 1e-6 && counter < 100
    %     tangent = (convert_4d_to_2d(get_res_tangent(mu_neq, m_neq, n_neq, eta_d, C_mid, Gamma_old, Gamma_new, dt)));
    %     residual = (convert_2d_to_1d(get_res(mu_neq, m_neq, n_neq, eta_d, C_mid, Gamma_old, Gamma_new, dt)));
    %     incremental = (convert_1d_to_2d(bicgstab(tangent, -residual)));
    %     Gamma_new = Gamma_new + incremental;
    %     counter = counter + 1;
    %     error = norm(residual);
    % end
    if ii == 1
        dt = time(ii);
        Gamma_old = eye(3);
        C_old = eye(3);
        Q_proj = get_proj_Q(m_neq, n_neq, Gamma_old);
        T_neq = get_T_neq(mu_neq, m_neq, n_neq, C_old, Gamma_old);
        Q = contract(T_neq, Q_proj);
        out(:,:,ii) = Gamma_old + 2.0 .* dt ./ eta_d .* Q;
    else
        dt = time(ii) - time(ii-1);
        Gamma_old = out(:,:,ii-1);
        C_old = Ft(:,:,ii-1)' * Ft(:,:,ii-1);
        Q_proj = get_proj_Q(m_neq, n_neq, Gamma_old);
        T_neq = get_T_neq(mu_neq, m_neq, n_neq, C_old, Gamma_old);
        Q = contract(T_neq, Q_proj);
        out(:,:,ii) = Gamma_old + 2.0 .* dt ./ eta_d .* Q;
    end
end
end