function out = get_CR_strain(m, n, C)
[V, D] = eig(C);
lambda = [sqrt(D(1,1)); sqrt(D(2,2)); sqrt(D(3,3))];
eig_val_CR_strain = get_CR_eig_val(m, n, lambda);
out = tensor_product(V, eig_val_CR_strain);
end