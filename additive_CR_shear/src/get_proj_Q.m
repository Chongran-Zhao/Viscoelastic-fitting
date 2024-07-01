% refer to eqn. 2.8 of Liu, Guan, Zhao & Luo 2024 preprint
% The input C can also be replaced by Gamma, because the transformation
% of E and C is same with Ev and Gamma
function out = get_proj_Q(m_eq, n_eq, C)
[V, D] = eig(C);

lambda = [sqrt(D(1,1)); sqrt(D(2,2)); sqrt(D(3,3))];
eig_val_E = get_CR_eig_val(m_eq, n_eq, lambda);
d = get_CR_eig_val_der(m_eq, n_eq, lambda, 1) ./ lambda;
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
    out = out + d(ii) .* cross_otimes_1d_to_4d(V(:,ii), V(:,ii), V(:,ii), V(:,ii));
    for jj = 1:3
        if jj ~= ii
            out = out + theta(ii,jj) .* dot_otimes(V(:,ii), V(:,jj));
        end
    end
end
end