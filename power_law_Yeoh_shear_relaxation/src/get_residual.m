function out = get_residual(eig_val_eps, eig_val_eps_tr, factor)
out = zeros(3,1);
for ii = 1:3
    out(ii) = eig_val_eps(ii) - eig_val_eps_tr(ii) + factor(ii);
end
end