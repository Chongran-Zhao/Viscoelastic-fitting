function [e1, e2, e3, v1, v2, v3] = eigen_decomp(A)
[V, D] = eig(A);
e1 = D(1,1);
e2 = D(2,2);
e3 = D(3,3);

v1 = V(:,1);
v2 = V(:,2);
v3 = V(:,3);
end