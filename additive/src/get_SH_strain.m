function out = get_SH_strain(m, C)
[V, D] = eig(C);
lambda = [sqrt(D(1,1)); sqrt(D(2,2)); sqrt(D(3,3))];
eig_val_SH_strain = get_SH_eig_val(m, lambda);
out = tensor_product(V, eig_val_SH_strain);
end