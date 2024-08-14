clc; clear; close all

addpath("src");
% No.1 monotonic shear data
data_1 = readmatrix('../exp_data_shear/monotonic_shear_1.csv');
time_1 = data_1(:,1);
P_exp_1 = data_1(:,3);
gamma_1 = data_1(:,4);

Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

% No.2 monotonic shear data
data_2 = readmatrix('../exp_data_shear/monotonic_shear_0d1.csv');
time_2 = data_2(:,1);
P_exp_2 = data_2(:,3);
gamma_2 = data_2(:,4);

Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

% No.3 monotonic shear data
data_3 = readmatrix('../exp_data_shear/monotonic_shear_0d01.csv');
time_3 = data_3(:,1);
P_exp_3 = data_3(:,3);
gamma_3 = data_3(:,4);

Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

% The length of mu_eq and alpha_eq should be the same
% mu_eq = [mu1_eq, mu2_eq]
% alpha_eq = [alpha1_eq, alpha2_eq]
mu_eq = [1.0];
alpha_eq = [1.0];

% The size of mu_neq and alpha_neq should be same
% The length of eta and the row number of mu_neq and alpha_neq should be same
% eta = [eta1, eta2]
% mu_neq = [mu1_neq1, mu2_neq1;
%           mu1_neq2, mu2_neq2]
% alpha_neq = [alpha1_neq1, alpha2_neq1;
%              alpha1_neq2, alpha2_neq2]

eta = [10.0, 10.0];
mu_neq = [1.0; 1.0];
alpha_neq = [1.0; 1.0];

% out = get_be_t(time, mu_neq, alpha_neq, eta, Ft)
[paras0, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq);

objectiveFunction = @(paras) multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                                    Ft_2, P_exp_2, time_2,...
                                                    Ft_3, P_exp_3, time_3,...
                                                    num_eq, num_neq, num_rel);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'trust-region-reflective', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_results(paras, num_eq, num_neq, num_rel,...
                            Ft_1, gamma_1, time_1, P_exp_1,...
                            Ft_2, gamma_2, time_2, P_exp_2,...
                            Ft_3, gamma_3, time_3, P_exp_3);
print(gcf, '-djpeg', 'fig_sim.jpg');