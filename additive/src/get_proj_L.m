% The function is used to obtain six-order projection tensor L
% refer to eqn. 2.11 of Liu, Guan, Zhao & Luo 2024 preprint
function out = get_proj_L(m, n, F)
out = zeros(3,3,3,3,3,3);
C = transpose(F) * F;
[V, D] = eig(C);
lambda = [sqrt(D(1,1)); sqrt(D(2,2)); sqrt(D(3,3))];

N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);

M1 = kron(N1, N1');
M2 = kron(N2, N2');
M3 = kron(N3, N3');

E = get_CR_eig_val(m, n, lambda);
E_der = get_CR_eig_val_der(m, n, lambda);
E_der2 = get_CR_eig_val_der2(m, n, lambda);

% first part
f = -1.0 ./ (lambda.^3) .* E_der + 1.0 ./ (lambda.^2) .* E_der2;
out = out + f(1) .* cross_otimes_2d_to_6d(M1, M1, M1);
out = out + f(2) .* cross_otimes_2d_to_6d(M2, M2, M2);
out = out + f(3) .* cross_otimes_2d_to_6d(M3, M3, M3);

d = E_der ./ lambda;

theta = zeros(3,3);
xi = zeros(3,3);
if lambda(1) == lambda(2)
    theta(1,2) = d(1);
    xi(1,2) = f(1) / 8.0;
    xi(2,1) = f(2) / 8.0;
else
    theta(1,2) = 2.0 * (E(1) - E(2)) / (lambda(1)^2 - lambda(2)^2);
    xi(1,2) = 0.5 * (theta(1,2) - d(2)) / (lambda(1)^2 - lambda(2)^2);
    xi(2,1) = 0.5 * (theta(2,1) - d(1)) / (lambda(2)^2 - lambda(1)^2);
end
if lambda(2) == lambda(3)
    theta(2,3) = d(2); 
    xi(2,3) = f(2) / 8.0;
    xi(3,2) = f(3) / 8.0;
else
    theta(2,3) = 2.0 * (E(2) - E(3)) / (lambda(2)^2 - lambda(3)^2);
    xi(2,3) = 0.5 * (theta(2,3) - d(3)) / (lambda(2)^2 - lambda(3)^2);
    xi(3,2) = 0.5 * (theta(3,2) - d(2)) / (lambda(3)^2 - lambda(2)^2);
end
if lambda(3) == lambda(1)
    theta(3,1) = d(3); 
    xi(3,1) = f(3) / 8.0;
    xi(1,3) = f(1) / 8.0;
else
    theta(3,1) = 2.0 * (E(3) - E(1)) / (lambda(3)^2 - lambda(1)^2);
    xi(3,1) = 2.0 * (theta(3,1) - d(1)) / (lambda(3)^2 - lambda(1)^2);
    xi(1,3) = 2.0 * (theta(1,3) - d(3)) / (lambda(1)^2 - lambda(3)^2);
end

% second part
out = out + xi(1,2) .* (get_H_abc(N1, N2, N2) + get_H_abc(N2, N1, N2) + get_H_abc(N2, N2, N1));
out = out + xi(1,3) .* (get_H_abc(N1, N3, N3) + get_H_abc(N3, N1, N3) + get_H_abc(N3, N3, N1));

out = out + xi(2,1) .* (get_H_abc(N2, N1, N1) + get_H_abc(N1, N2, N1) + get_H_abc(N1, N1, N2));
out = out + xi(2,3) .* (get_H_abc(N2, N3, N3) + get_H_abc(N3, N2, N3) + get_H_abc(N3, N3, N2));

out = out + xi(3,1) .* (get_H_abc(N3, N1, N1) + get_H_abc(N1, N3, N1) + get_H_abc(N1, N1, N3));
out = out + xi(3,2) .* (get_H_abc(N3, N2, N2) + get_H_abc(N2, N3, N2) + get_H_abc(N2, N2, N3));

eta = 0.0;
if (lambda(1) == lambda(2)) && (lambda(2) == lambda(3))
    eta = f(1) / 8.0;
end

if lambda(1) == lambda(2)
    eta = xi(3,1);
elseif lambda(2) == lambda(3)
    eta = xi(1,2);
elseif lambda(3) == lambda(1)
    eta = xi(2,3);
else
    for ii = 1:3
        for jj = 1:3
            if jj ~= ii
                for kk = 1:3
                    if (kk ~=ii) && (kk ~= jj)
                        eta = eta + 0.5 * E(ii) / ((lambda(ii)^2 - lambda(jj)^2) * (lambda(ii)^2 - lambda(kk)^2));
                    end
                end
            end
        end
    end
end

out = out + eta .* (get_H_abc(N1, N2, N3) + get_H_abc(N1, N3, N2));
out = out + eta .* (get_H_abc(N2, N1, N3) + get_H_abc(N2, N3, N1));
out = out + eta .* (get_H_abc(N3, N1, N2) + get_H_abc(N3, N2, N1));
end