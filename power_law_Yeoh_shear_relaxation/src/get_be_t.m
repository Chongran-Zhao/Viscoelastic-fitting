function out = get_be_t(time, xi_neq, C1, C2, tau_hat, power_m , Ft)
out = zeros(size(Ft));
for ii = 1:length(time)
    if ii == 1
        dt = time(ii);
        F_new = Ft(:,:,ii);
        be_tr = F_new * F_new';
        Cv_old = eye(3);
    else
        dt = time(ii) - time(ii-1);
        be_old = out(:,:,ii-1)
        det(be_old)
        F_old = Ft(:,:,ii-1);
        Cv_inv_old = get_Cv_inv(F_old, be_old);
        Cv_old = get_Cv(F_old, be_old)
        F_new = Ft(:,:,ii);
        be_tr = F_new * Cv_inv_old * F_new';
    end
    lambda_v_chain = get_lambda_chian(Cv_old)
    tau_iso_neq_tr = get_tau_iso_neq(xi_neq, be_tr);
    get_trace(tau_iso_neq_tr)
    N = tau_iso_neq_tr ./ get_norm(tau_iso_neq_tr);
    gamma_dot = get_gamma_dot(C1, C2, tau_hat, power_m, get_norm(tau_iso_neq_tr)/sqrt(2), lambda_v_chain)
    [V, D] = eig(N)
    N1 = V(:,1);
    N2 = V(:,2);
    N3 = V(:,3);
    dt
    be_new_1 = exp(-2.0 * gamma_dot * dt * D(1,1))
    be_new_2 = exp(-2.0 * gamma_dot * dt * D(2,2))
    be_new_3 = exp(-2.0 * gamma_dot * dt * D(3,3))
    out(:,:,ii) = tensor_product(be_new_1, be_new_2, be_new_3, N1, N2, N3) * be_tr;
    det(out(:,:,ii))
end
end
% EOF