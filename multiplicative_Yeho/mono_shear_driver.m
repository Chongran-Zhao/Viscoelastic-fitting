clc; clear; close all

addpath("src");
data = readmatrix('../monotonic_shear_1.csv');
time = data(:,1);
P1_exp = data(:,3);
gamma = data(:,4);

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

xi_eq = [1.0, 1.0, 1.0];
xi_neq = [1.0, 1.0, 0.1];
eta_d = 1.0;

% [paras0, lb, ub, num_eq, num_neq] = array_to_paras(xi_eq, xi_neq, eta_d);
% 
% objectiveFunction = @(paras) objective(paras, Ft, P1_exp, time, num_eq, num_neq);
% options = optimoptions('lsqnonlin', ...
%     'Algorithm', 'interior-point', ...
%     'MaxIterations', 1000, ...
%     'Display', 'iter');

% [paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
% 
% plot_result(paras, num_eq, num_neq, Ft, time, lambda1_exp, P1_exp);
% print(gcf, '-dpdf', 'fig_1.pdf');