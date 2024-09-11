clc; clear; close all

addpath("src");
data_1 = readmatrix('../exp-data/shear_relaxation_5.xlsx');
time_1 = data_1(:,1);
P_exp_1 = data_1(:,4);
gamma_1 = data_1(:,5);

Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

data_2 = readmatrix('../exp-data/shear_relaxation_2.xlsx');
time_2 = data_2(:,1);
P_exp_2 = data_2(:,4);
gamma_2 = data_2(:,5);

Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

data_3 = readmatrix('../exp-data/shear_relaxation_1.xlsx');
time_3 = data_3(:,1);
P_exp_3 = data_3(:,4);
gamma_3 = data_3(:,5);

% Uniaxial tension experimental case
Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

% parameters
mu_eq = [1.0];
m_eq = [1.0];
n_eq = [1.0];

mu_neq = [1.0, 1.0];
m_neq = [1.0, 1.0];
n_neq = [1.0, 1.0];
eta_d = [100.0, 1.0];

[paras0, num_eq, num_neq, lb, ub] = array_to_paras(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d);

objectiveFunction = @(paras) objective(paras, Ft_1, P_exp_1, time_1,...
                                              Ft_2, P_exp_2, time_2,...
                                              Ft_3, P_exp_3, time_3,...
                                              num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'trust-region-reflective', ...
    'MaxIterations', 1000, ...
    'MaxFunctionEvaluations', 2000, ...
    'Display', 'iter-detailed');

[paras, resnorm] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_results(paras, num_eq, num_neq,...
                            Ft_1, time_1, P_exp_1,...
                            Ft_2, time_2, P_exp_2,...
                            Ft_3, time_3, P_exp_3);
print(gcf, '-djpeg', 'results.jpg');