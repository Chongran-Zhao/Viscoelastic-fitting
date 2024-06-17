clc; clear; close all

addpath("src");

fid = fopen('../exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp = data{1}';
lambda1_exp = data{2}';
time = data{3}';

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = lambda1_exp(:);
Ft(2,2,:) = lambda1_exp(:).^(-0.5);
Ft(3,3,:) = lambda1_exp(:).^(-0.5);

% parameters
mu_eq = [1.0];
m_eq = [1.0];
n_eq = [1.0];

mu_neq = [1.0];
m_neq = [1.0];
n_neq = [1.0];
eta_d = [1.0];

[paras0, num_eq, num_neq, lb, ub] = array_to_paras(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d);

objectiveFunction = @(paras) objective(paras, Ft, P1_exp, time, num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter-detailed');

[paras, resnorm] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
plot_result(paras, num_eq, num_neq, Ft, time, lambda1_exp, P1_exp);
print(gcf, '-dpdf', 'fig_1.pdf');