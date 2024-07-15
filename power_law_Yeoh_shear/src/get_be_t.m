function out = get_be_t(time, xi_neq, tau_hat, power_m , Ft)
out = zeros(size(Ft));
for ii = 1:length(time)
        if ii == 1
            dt = time(ii);
            be_tr = eye(3);
            be_old = eye(3);
        else
            dt = time(ii) - time(ii-1);
            be_old = out(:,:,ii-1);
            F_old = Ft(:,:,ii-1);
            Cv_inv_old = get_Cv_inv(F_old, be_old);
            F_new = Ft(:,:,ii);
            be_tr = F_new * Cv_inv_old * F_new';
        end
        [V, D] = eig(be_tr);
        lambda1 = sqrt(D(1,1));
        lambda2 = sqrt(D(2,2));
        lambda3 = sqrt(D(3,3));
        N1 = V(:,1);
        N2 = V(:,2);
        N3 = V(:,3);
        tau_1_tr = get_tau_iso_eig_val(xi_neq, lambda1, lambda2, lambda3);
        tau_2_tr = get_tau_iso_eig_val(xi_neq, lambda2, lambda1, lambda3);
        tau_3_tr = get_tau_iso_eig_val(xi_neq, lambda3, lambda1, lambda1);
        tau_iso_neq_tr = get_tau_iso_neq(xi_neq, be_tr);
        tau_norm = get_norm(tau_iso_neq_tr);
        gamma_dot = get_gamma_dot(tau_hat, power_m, get_norm(tau_iso_neq_tr)/sqrt(2));
        be_1_new = exp(-2.0 / tau_norm * dt * gamma_dot * tau_1_tr) * D(1,1);
        be_2_new = exp(-2.0 / tau_norm * dt * gamma_dot * tau_2_tr) * D(2,2);
        be_3_new = exp(-2.0 / tau_norm * dt * gamma_dot * tau_3_tr) * D(3,3);
        out(:,:,ii) = tensor_product(be_1_new, be_2_new, be_3_new, N1, N2, N3);
        % N_tr = get_N(xi_neq, be_tr);
        % incremental = -2.0 * gamma_dot * dt .* N_tr * be_tr;
        % out(:,:,ii) = incremental + be_tr;
end
end
% EOF