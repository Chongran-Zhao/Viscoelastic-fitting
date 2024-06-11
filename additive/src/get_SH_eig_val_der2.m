function out = get_SH_eig_val_der2(m, lambda)
out = [get_SH_scale_der2(m,lambda(1)); get_SH_scale_der2(m,lambda(2)); get_SH_scale_der2(m,lambda(3))];
end