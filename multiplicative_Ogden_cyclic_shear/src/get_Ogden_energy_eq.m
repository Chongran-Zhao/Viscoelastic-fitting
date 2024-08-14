function out = get_Ogden_energy_eq(mu_eq, alpha_eq, C)
out = 0.0;
[V, D] = eig(C);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
for ii = 1:length(mu_eq)
    out = out + mu_eq(ii) / alpha_eq(ii) * (lambda1^alpha_eq(ii) + lambda2^alpha_eq(ii) + lambda3^alpha_eq(ii) - 3.0);
end
end