function out = get_SH_eig_val_der(m, lambda)
out = [get_SH_scale_der(m,lambda(1)); get_SH_scale_der(m,lambda(2)); get_SH_scale_der(m,lambda(3))];
end