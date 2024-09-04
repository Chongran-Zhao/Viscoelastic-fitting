function out = get_be_t(time, xi_neq, C1, C2, tau_hat, power_m , Ft)
out = zeros(size(Ft));
for ii = 1:length(time)
    ii
    if ii == 1
        dt = time(ii)
        Cv_inv_old = eye(3);
        Cv_old = eye(3);
    else
        dt = time(ii) - time(ii-1)
        Cv_inv_old = get_Cv_inv(Ft(:,:,ii-1), out(:,:,ii-1));
        Cv_old = get_Cv(Ft(:,:,ii-1), out(:,:,ii-1));
    end
    be_tr = Ft(:,:,ii) * Cv_inv_old * transpose(Ft(:,:,ii));
    [be_tr1, be_tr2, be_tr3, v1, v2, v3] = eigen_decomp(be_tr);
    be1 = be_tr1;
    be2 = be_tr2;
    be3 = be_tr3;
    eps1 = 0.5 * log(be1);
    eps2 = 0.5 * log(be2);
    eps3 = 0.5 * log(be3);
    eps_tr1 = eps1;
    eps_tr2 = eps2;
    eps_tr3 = eps3;
    
    lambda_v_chain = get_lambda_chian(Cv_old);
    error = 1.0;
    tol = 1.0e-5;
    max_it_num = 10000;
    counter = 0;
    while (error > tol) && (counter < max_it_num)
        [dev_tau_1, dev_tau_2, dev_tau_3] = get_dev_tau_a(xi_neq, be1, be2, be3);
        dev_tau_iso_neq = tensor_product(dev_tau_1, dev_tau_2, dev_tau_3, v1, v2, v3);
        tau_v = get_norm(dev_tau_iso_neq) / sqrt(2);
        gamma_dot = get_gamma_dot(C1, C2, tau_hat, power_m, tau_v, lambda_v_chain);

        beta1 = dt / (2.0*sqrt(2)) * (power_m-1.0) * C1 / (tau_hat^power_m) * lambda_v_chain^C2 * tau_v^(power_m - 3.0);
        beta2 = dt * gamma_dot / (tau_v * sqrt(2));
        factor = dt / sqrt(2) * gamma_dot / tau_v .* [dev_tau_1, dev_tau_2, dev_tau_3];

        residual = get_residual([eps1, eps2, eps3], [eps_tr1, eps_tr2, eps_tr3], factor)
        tangent = get_tangent(xi_neq, be1, be2, be3, beta1, beta2);
        error = norm(residual)

        incremental = tangent \ (-residual);
        eps1 = eps1 + incremental(1);
        eps2 = eps2 + incremental(2);
        eps3 = eps3 + incremental(3);

        be1 = exp(2.0 * eps1);
        be2 = exp(2.0 * eps2);
        be3 = exp(2.0 * eps3);
        counter = counter + 1;
    end
    out(:,:,ii) = tensor_product(be1, be2, be3, v1, v2, v3);
    tensor_product(be1, be2, be3, v1, v2, v3)
    det(out(:,:,ii))
    counter
    error
end
end
% EOF