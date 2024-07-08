clc; clear; close all

addpath("src");

% No.1 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P_exp_1 = data{1}';
lambda_exp_1 = data{2}';
time_1 = data{3}';

Ft_1 = zeros(3,3,length(lambda_exp_1));
Ft_1(1,1,:) = lambda_exp_1(:);
Ft_1(2,2,:) = lambda_exp_1(:).^(-0.5);
Ft_1(3,3,:) = lambda_exp_1(:).^(-0.5);

% No.2 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d3.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P_exp_2 = data{1}';
lambda_exp_2 = data{2}';
time_2 = data{3}';

Ft_2 = zeros(3,3,length(lambda_exp_2));
Ft_2(1,1,:) = lambda_exp_2(:);
Ft_2(2,2,:) = lambda_exp_2(:).^(-0.5);
Ft_2(3,3,:) = lambda_exp_2(:).^(-0.5);

% No.3 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d03.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P_exp_3 = data{1}';
lambda_exp_3 = data{2}';
time_3 = data{3}';

Ft_3 = zeros(3,3,length(lambda_exp_3));
Ft_3(1,1,:) = lambda_exp_3(:);
Ft_3(2,2,:) = lambda_exp_3(:).^(-0.5);
Ft_3(3,3,:) = lambda_exp_3(:).^(-0.5);

% No.4 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d6.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P_exp_4 = data{1}';
lambda_exp_4 = data{2}';
time_4 = data{3}';

Ft_4 = zeros(3,3,length(lambda_exp_4));
Ft_4(1,1,:) = lambda_exp_4(:);
Ft_4(2,2,:) = lambda_exp_4(:).^(-0.5);
Ft_4(3,3,:) = lambda_exp_4(:).^(-0.5);

% No.5 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P_exp_5 = data{1}';
lambda_exp_5 = data{2}';
time_5 = data{3}';

Ft_5 = zeros(3,3,length(lambda_exp_5));
Ft_5(1,1,:) = lambda_exp_5(:);
Ft_5(2,2,:) = lambda_exp_5(:).^(-0.5);
Ft_5(3,3,:) = lambda_exp_5(:).^(-0.5);


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

eta = [100.0, 100.0];
mu_neq = [1.0; -1.0];
alpha_neq = [1.0; -1.0];

[paras0, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq);

objectiveFunction = @(paras) multi_objective(paras, Ft_1, P_exp_1, time_1,...
                                                    Ft_2, P_exp_2, time_2,...
                                                    Ft_3, P_exp_3, time_3,...
                                                    Ft_4, P_exp_4, time_4,...
                                                    Ft_5, P_exp_5, time_5,...
                                                    num_eq, num_neq, num_rel);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_results(paras, num_eq, num_neq, num_rel,...
                            time_1, lambda_exp_1, P_exp_1,...
                            time_2, lambda_exp_2, P_exp_2,...
                            time_3, lambda_exp_3, P_exp_3,...
                            time_4, lambda_exp_4, P_exp_4,...
                            time_5, lambda_exp_5, P_exp_5);
print(gcf, '-djpeg', 'fig_sim_2.jpg');