function out = get_BI_strain(m, C)
[V, D] = eig(C);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
E1 = get_BI_scale(m, lambda1);
E2 = get_BI_scale(m, lambda2);
E3 = get_BI_scale(m, lambda3);
out = tensor_product(E1, E2, E3, N1, N2, N3);
end