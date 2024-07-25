function [samples, lb, ub] = array_to_paras(num_eq, num_neq, num_mullins, num_samples)
lb = [];
ub = [];
% mu m n
for ii = 1:num_eq
    lb = [lb, 0, -10, -10];
    ub = [ub, 1.0e-1, 10, 10];
end

% mu m n eta
for ii = 1:num_neq
    lb = [lb, 0, -10, -10, 0.0];
    ub = [ub, 1.0e-1, 10, 10, 1.0e3];
end
% m r beta
lb = [lb, -1.0e2, -1.0e4, 0.0];
ub = [ub, 1.0e2, 1.0e4, 1.0e2];
range = [];

dim = 3*num_eq + 4*num_neq + num_mullins;
samples = lhsdesign(num_samples, dim);
for ii = 1:length(num_samples)
samples(ii,:) = lb +(ub - lb) .* samples(ii,:);
end
end