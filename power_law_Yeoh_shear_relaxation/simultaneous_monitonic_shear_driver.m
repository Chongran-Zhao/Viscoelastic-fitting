clc; clear; close all

addpath("src");

addpath("src");
data_1 = readmatrix('../exp_data_shear_relaxation/shear_relaxation_5.xlsx');
time_1 = data_1(:,1);
P_exp_1 = data_1(:,4);
gamma_1 = data_1(:,5);

% Uniaxial tension experimental case
Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

data_2 = readmatrix('../exp_data_shear_relaxation/shear_relaxation_2.xlsx');
time_2 = data_2(:,1);
P_exp_2 = data_2(:,4);
gamma_2 = data_2(:,5);

% Uniaxial tension experimental case
Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

data_3 = readmatrix('../exp_data_shear_relaxation/shear_relaxation_1.xlsx');
time_3 = data_3(:,1);
P_exp_3 = data_3(:,4);
gamma_3 = data_3(:,5);

% Uniaxial tension experimental case
Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

xi_eq = [1.0, 1.0, 1.0];
xi_neq = [1.0, 1.0, 1.0;
          1.0, 1.0, 1.0];
C1 = [1.0, 1.0];
C2 = [-0.1, -0.1];
tau_hat = [1.1, 1.1];
power_m = [2.1, 2.1];

[paras0, lb, ub] = array_to_paras(xi_eq, xi_neq, C1, C2, tau_hat, power_m);

objectiveFunction = @(paras) multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                      Ft_2, P_exp_2, time_2,...
                                      Ft_3, P_exp_3, time_3);

options = optimoptions('lsqnonlin', ...
    'Algorithm', 'trust-region-reflective', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
plot_results(paras, time_1, gamma_1, P_exp_1,...
                                     time_2, gamma_2, P_exp_2,...
                                     time_3, gamma_3, P_exp_3);
print('-djpeg', 'fig_sim.jpg');
