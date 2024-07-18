% D is a 1x3 vector containing three eigenvalues
% V is a 3x3 matrix containing three cooresponidng eigenvectors
function out = tensor_product(e1, e2, e3, N1, N2, N3)
out = e1 .* kron(N1, N1');
out = out + e2 .* kron(N2, N2');
out = out + e3 .* kron(N3, N3');
end