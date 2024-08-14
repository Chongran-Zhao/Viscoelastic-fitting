function out = tensor_exp(A)
[V, D] = eig(A);
coe = [exp(D(1,1)), exp(D(2,2)), exp(D(3,3))];
out = tensor_product(V, coe);
end