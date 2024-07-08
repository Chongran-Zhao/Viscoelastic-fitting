clc; clear; close all

addpath("src");
data = readmatrix('../monotonic_shear_0d01.csv');
time = data(:,1);
P_exp = data(:,3);
gamma = data(:,4);

% Uniaxial tension experimental casex
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

% xi_eq = [0.0068, -1.04e-4, 7e-7];
% xi_neq = [0.041, -0.009, 0.004];
xi_eq = [1.0e-1, 1.0e-2, 1.0e-3];
xi_neq = [1.0e-1, 1.0e-2, 1.0e-3];
eta_d = 1000.0;

[paras0, lb, ub, num_eq, num_neq] = array_to_paras(xi_eq, xi_neq, eta_d);

objectiveFunction = @(paras) objective(paras, Ft, P_exp, time, num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_result(paras, num_eq, num_neq, Ft, time, gamma, P_exp, 0.01);
print('-djpeg', 'fig_0d01.jpg');
