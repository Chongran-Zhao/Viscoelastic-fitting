clc; clear; close all

addpath("src");

% No.1 shear experimental data
data_1 = readmatrix('../monotonic_shear_1.csv');
time_1 = data_1(:,1);
P_exp_1 = data_1(:,3);
gamma_1 = data_1(:,4);

Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

% No.2 shear experimental data
data_2 = readmatrix('../monotonic_shear_0d1.csv');
time_2 = data_2(:,1);
P_exp_2 = data_2(:,3);
gamma_2 = data_2(:,4);

Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

% No.3 shear experimental data
data_3 = readmatrix('../monotonic_shear_0d01.csv');
time_3 = data_3(:,1);
P_exp_3 = data_3(:,3);
gamma_3 = data_3(:,4);

Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

% parameters
mu_eq = [1.0];
m_eq = [1.0];
n_eq = [1.0];

mu_neq = [10.0];
m_neq = [1.0];
n_neq = [1.0];
eta_d = [1.0e4];
[paras0, num_eq, num_neq, lb, ub] = array_to_paras(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d);

objectiveFunction = @(paras) multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                                    Ft_2, P_exp_2, time_2,...
                                                    Ft_3, P_exp_3, time_3,...
                                                    num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter-detailed');

[paras, resnorm] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);
plot_results(paras, num_eq, num_neq, Ft_1, time_1, P_exp_1,...
                                     Ft_2, time_2, P_exp_2,...
                                     Ft_3, time_3, P_exp_3);
print(gcf, '-djpeg', 'fig_shear_sim.jpg');