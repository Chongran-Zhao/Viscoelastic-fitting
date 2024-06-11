function out = get_Gamma_t(mu, m, n, eta_d, Ft, time)
out = zeros(3,3,length(time));
error = 1.0;
counter = 0;
for ii = 1:length(time)
    if ii == 1
        F_old = eye(3);
        F_new = Ft(:,:,1);
        Gamma_old = eye(3);
        Gamma_new = eye(3);
        dt = time(1);
    else
        F_old = eye(ii-1);
        F_new = eye(3);
        Gamma_old = out(:,:,ii-1);
        Gamma_new = out(:,:,ii-1);
        dt = time(ii) - time(ii-1);
    end

    while error > 1e-6 && counter < 10
        tangent = get_res_tangent(mu, m, n, eta_d, Gamma_old, Gamma_new, F_old, F_new, dt);
        residual = get_res(mu, m, n, eta_d, Gamma_old, Gamma_new, F_old, F_new, dt);
        incremental = -residual \ tangent;
        Gamma_new = Gamma_new + incremental;
        counter = counter + 1;
    end
    out(:,:,ii) = Gamma_new;
end
end