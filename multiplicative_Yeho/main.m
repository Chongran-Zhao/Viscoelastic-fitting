clc; clear; close all

addpath("src");

fid = fopen('../exp_data_UT/data_1.txt', 'r');
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

xi_eq = [1.0, 1.0, 1.0];
xi_neq = [1.0, 1.0, 1.0];
eta_d = 1.0;
out = get_be_t(time, xi_neq, eta_d, Ft)

[paras0, lb, ub, num_eq, num_neq] = array_to_paras(xi_eq, xi_neq, eta_d);

objectiveFunction = @(paras) objective(paras, Ft, P1_exp, time, num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_result(paras, num_eq, num_neq, Ft, time, lambda1_exp, P1_exp);
print(gcf, '-dpdf', 'fig_1.pdf');