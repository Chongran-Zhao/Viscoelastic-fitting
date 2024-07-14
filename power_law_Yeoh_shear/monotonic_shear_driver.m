clc; clear; close all

addpath("src");
data = readmatrix('../exp_data_shear/monotonic_shear_1.csv');
time = data(:,1);
P_exp = data(:,3);
gamma = data(:,4);

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

xi_eq = [1.0e-4, -1.0e-1, 1.0e-2];
xi_neq = [1.0e-4, -1.0e-1, 1.0e-2];
tau_hat = 1.0;
power_m = 1.0;

[paras0, lb, ub] = array_to_paras(xi_eq, xi_neq, tau_hat, power_m);
objectiveFunction = @(paras) objective(paras, Ft, P_exp, time);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'levenberg-marquardt', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_result(paras, time, gamma, P_exp, 1);
print(gcf, '-djpeg', 'fig_1.jpg');