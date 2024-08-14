function out = get_Ogden_energy_neq(mu_neq, alpha_neq, be)
out = 0.0;
[V, D] = eig(be);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
for ii = 1:length(mu_neq)
    out = out + mu_neq(ii) / alpha_neq(ii) * (lambda1^alpha_neq(ii) + lambda2^alpha_neq(ii) + lambda3^alpha_neq(ii) - 3.0);
end
end