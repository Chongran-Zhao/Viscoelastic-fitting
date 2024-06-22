clc; clear; close all

addpath("src");

% No.1 monotonic shear data
data_1 = readmatrix('../monotonic_shear_1.csv');
time_1 = data_1(:,1);
P_shear_exp_1 = data_1(:,3);
gamma_1 = data_1(:,4);

Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

% No.2 monotonic shear data
data_2 = readmatrix('../monotonic_shear_0.1.csv');
time_2 = data_2(:,1);
P_shear_exp_2 = data_2(:,3);
gamma_2 = data_2(:,4);

Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

% No.3 monotonic shear data
data_3 = readmatrix('../monotonic_shear_0.01.csv');
time_3 = data_3(:,1);
P_shear_exp_3 = data_3(:,3);
gamma_3 = data_3(:,4);

Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

% xi_eq = [0.0068, -1.04e-4, 7e-7];
% xi_neq = [0.041, -0.009, 0.004];
xi_eq = [1.0e-1, -1.0e-2, 1.0e-3];
xi_neq = [1.0e-1, -1.0e-2, 1.0e-3];
eta_d = 100.0;

[paras0, lb, ub, num_eq, num_neq] = array_to_paras(xi_eq, xi_neq, eta_d);

objectiveFunction = @(paras) objective(paras, Ft_1, P_shear_exp_1, time_1, num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
plot_results(paras, num_eq, num_neq, Ft_1, time_1, gamma_1, P_shear_exp_1,...
                                     Ft_2, time_2, gamma_2, P_shear_exp_2,...
                                     Ft_3, time_3, gamma_3, P_shear_exp_3);
paras0 = paras;

objectiveFunction = @(paras) double_objective(paras, Ft_3, P_shear_exp_3, time_3,...
                                                    Ft_2, P_shear_exp_2, time_2,...
                                                    num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
plot_results(paras, num_eq, num_neq, Ft_1, time_1, gamma_1, P_shear_exp_1,...
                                     Ft_2, time_2, gamma_2, P_shear_exp_2,...
                                     Ft_3, time_3, gamma_3, P_shear_exp_3);
paras0 = paras;

objectiveFunction = @(paras) multi_objective(paras, Ft_1, P_shear_exp_1, time_1,...
                                                    Ft_2, P_shear_exp_2, time_2,...
                                                    Ft_3, P_shear_exp_3, time_3,...
                                                    num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_results(paras, num_eq, num_neq, Ft_1, time_1, gamma_1, P_shear_exp_1,...
                                     Ft_2, time_2, gamma_2, P_shear_exp_2,...
                                     Ft_3, time_3, gamma_3, P_shear_exp_3);
% print(gcf, '-dpdf', 'fig_sim.pdf');
print('-djpeg', 'fig_sim.jpg');
