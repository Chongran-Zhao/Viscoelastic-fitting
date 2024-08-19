function out = get_gamma_dot(C1, C2, tau_hat, power_m, tau_v, lambda_v_chain)
out = C1 * (lambda_v_chain - 1.0 + 1.0e-3)^C2 * (tau_v / tau_hat)^power_m;
end