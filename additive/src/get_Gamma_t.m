function out = get_Gamma_t(mu_neq, m_neq, n_neq, eta_d, Ft, time)
out = zeros(3,3,length(time));
for ii = 1:length(time)
    error = 1.0;
    counter = 0;
    if ii == 1
        F_old = eye(3);
        F_new = Ft(:,:,ii);
        Gamma_old = eye(3);
        Gamma_new = eye(3);
        dt = time(ii);
    else
        F_old = Ft(:,:,ii-1);
        F_new = Ft(:,:,ii);
        Gamma_old = out(:,:,ii-1);
        Gamma_new = Gamma_old;
        dt = time(ii) - time(ii-1);
    end
    F_mid = 0.5 .* (F_old + F_new);
    while error > 1e-6 && counter < 10
        tangent = convert_4d_to_2d(get_res_tangent(mu_neq, m_neq, n_neq, eta_d, F_mid, Gamma_old, Gamma_new, dt));
        residual = convert_2d_to_1d(get_res(mu_neq, m_neq, n_neq, eta_d, F_mid, Gamma_old, Gamma_new, dt));
        incremental = convert_1d_to_2d(bicgstab(tangent, -residual));
        Gamma_new = Gamma_new + incremental;
        counter = counter + 1;
        error = norm(residual);
    end
    out(:,:,ii) = Gamma_new;
end
end