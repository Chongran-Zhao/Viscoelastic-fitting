function out = get_Fe_t(time, xi_neq, tau_hat, power_m , Ft)
out = zeros(size(Ft));
for ii = 1:length(time)
    if ii == 1
        F_old = eye(3);
        Fe_old = eye(3);
        Fv_old = eye(3);
        dt = time(ii);
    else
        F_old = Ft(:,:,ii-1);
        Fe_old = out(:,:,ii-1);
        Fv_old = inv(Fe_old) * F_old;
        dt = time(ii) - time(ii-1);
    end
    sigma_neq_old = get_sigma_neq(xi_neq, Fe_old, F_old);
    tau_old = 0.0;
    for kk = 1:3
        for ll = 1:3
            out = out + sigma_neq_old(kk,ll)*sigma_neq_old(kk,ll);
        end
    end
    N_old = sigma_neq_old ./ tau_old;
    Fv_new = dt * (tau_old / tau_hat)^power_m .* Fv_old * inv(F_old) * N_old * F_old + F_old;
    F_new = Ft(:,:,ii);
    Fe_new = F_new * inv(Fv_new);
    out(:,:,ii) = Fe_new;
end
end
% EOF