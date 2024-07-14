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
        tau_iso_neq_tr = get_tau_iso_neq(xi_neq, be_tr);
        tau_v_tr = get_norm(tau_iso_neq_tr) / sqrt(2);
        N_tr = get_N(xi_neq, be_tr);
        incremental = -2.0 * (tau_v_tr / tau_hat)^power_m * dt .* N_tr;
        out(:,:,ii) = incremental + be_tr;
end
end
% EOF