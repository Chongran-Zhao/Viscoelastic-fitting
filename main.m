clc; clear; close all

addpath("src");

fid = fopen('./exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp = data{1}';
lambda1_exp = data{2}';
time = data{3}';

% Uniaxial tension experimental case
Ft = zeros(3,3,length(lambda1_exp));
Ft(1,1,:) = lambda1_exp(:);
Ft(2,2,:) = lambda1_exp(:).^(-0.5);
Ft(3,3,:) = lambda1_exp(:).^(-0.5);

% The length of mu_eq and alpha_eq should be the same
% mu_eq = [mu1_eq, mu2_eq]
% alpha_eq = [alpha1_eq, alpha2_eq]
mu_eq = [1.0, 1.0, 1.0];
alpha_eq = [1.0, 1.0, 1.0];

% The size of mu_neq and alpha_neq should be same
% The length of eta and the row number of mu_neq and alpha_neq should be same
% eta = [eta1, eta2]
% mu_neq = [mu1_neq1, mu2_neq1;
%           mu1_neq2, mu2_neq2]
% alpha_neq = [alpha1_neq1, alpha2_neq1;
%              alpha1_neq2, alpha2_neq2]

eta = [1.0, 1.0];
mu_neq = [1.0, 1.0, 1.0;...
          1.0, 1.0, 1.0];
alpha_neq = [1.0, 1.0, 1.0;...
             1.0, 1.0, 1.0];

[paras0, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq);

objectiveFunction = @(paras) objective(paras, Ft, P1_exp, time, num_eq, num_neq, num_rel);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'levenberg-marquardt', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_result(paras, num_eq, num_neq, num_rel, Ft, time, lambda1_exp, P1_exp);