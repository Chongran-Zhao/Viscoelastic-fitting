% refer to eqn. 2.8 & 2.26 of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_proj_Q_v(m, n, Gamma)
[V, D] = eig(Gamma);
M = zeros(3,3,3);
M(:,:,1) = kron(V(:,1), V(:,1)');
M(:,:,2) = kron(V(:,2), V(:,2)');
M(:,:,3) = kron(V(:,3), V(:,3)');

lambda = [sqrt(D(1,1)); sqrt(D(2,2)); sqrt(D(3,3))];
eig_val_E = get_CR_eig_val(m, n, lambda);
d = get_CR_eig_val_der(m, n, lambda) ./ lambda;
theta = zeros(3,3);
if lambda(1) == lambda(2)
    theta(1,2) = d(1); 
else
    theta(1,2) = 2.0 * (eig_val_E(1) - eig_val_E(2)) / (lambda(1)^2 - lambda(2)^2);
end
if lambda(2) == lambda(3)
    theta(2,3) = d(2); 
else
    theta(2,3) = 2.0 * (eig_val_E(2) - eig_val_E(3)) / (lambda(2)^2 - lambda(3)^2);
end
if lambda(3) == lambda(1)
    theta(3,1) = d(3); 
else
    theta(3,1) = 2.0 * (eig_val_E(3) - eig_val_E(1)) / (lambda(3)^2 - lambda(1)^2);
end
theta(2,1) = theta(1,2);
theta(3,2) = theta(2,3);
theta(1,3) = theta(3,1);

out = zeros(3,3,3,3);
for ii = 1:3
    out = out + d(ii) .* cross_otimes_2d_to_4d(M(:,:,ii), M(:,:,ii));
    for jj = 1:3
        if jj ~= ii
            out = out + theta(ii,jj) .* dot_otimes(M(:,:,ii), M(:,:,jj));
        end
    end
end
end