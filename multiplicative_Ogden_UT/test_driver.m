clc; clear; close all

addpath("src");

% No.1 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp_0d1 = data{1}';
lambda1_exp_0d1 = data{2}';
time_0d1 = data{3}';

Ft_0d1 = zeros(3,3,length(lambda1_exp_0d1));
Ft_0d1(1,1,:) = lambda1_exp_0d1(:);
Ft_0d1(2,2,:) = lambda1_exp_0d1(:).^(-0.5);
Ft_0d1(3,3,:) = lambda1_exp_0d1(:).^(-0.5);

% No.2 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d3.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp_0d3 = data{1}';
lambda1_exp_0d3 = data{2}';
time_0d3 = data{3}';

Ft_0d3 = zeros(3,3,length(lambda1_exp_0d3));
Ft_0d3(1,1,:) = lambda1_exp_0d3(:);
Ft_0d3(2,2,:) = lambda1_exp_0d3(:).^(-0.5);
Ft_0d3(3,3,:) = lambda1_exp_0d3(:).^(-0.5);

% No.3 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d03.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp_0d03 = data{1}';
lambda1_exp_0d03 = data{2}';
time_0d03 = data{3}';

Ft_0d03 = zeros(3,3,length(lambda1_exp_0d03));
Ft_0d03(1,1,:) = lambda1_exp_0d03(:);
Ft_0d03(2,2,:) = lambda1_exp_0d03(:).^(-0.5);
Ft_0d03(3,3,:) = lambda1_exp_0d03(:).^(-0.5);

% No.4 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_0d6.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp_0d6 = data{1}';
lambda1_exp_0d6 = data{2}';
time_0d6 = data{3}';

Ft_0d6 = zeros(3,3,length(lambda1_exp_0d6));
Ft_0d6(1,1,:) = lambda1_exp_0d6(:);
Ft_0d6(2,2,:) = lambda1_exp_0d6(:).^(-0.5);
Ft_0d6(3,3,:) = lambda1_exp_0d6(:).^(-0.5);

% No.5 Uniaxial tension experimental case
fid = fopen('../exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp_1 = data{1}';
lambda1_exp_1 = data{2}';
time_1 = data{3}';

Ft_1 = zeros(3,3,length(lambda1_exp_1));
Ft_1(1,1,:) = lambda1_exp_1(:);
Ft_1(2,2,:) = lambda1_exp_1(:).^(-0.5);
Ft_1(3,3,:) = lambda1_exp_1(:).^(-0.5);


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

eta = [1.0];
mu_neq = [1.0];
alpha_neq = [1.0];

[paras0, lb, ub, num_eq, num_neq, num_rel] = array_to_paras(mu_eq, alpha_eq, eta, mu_neq, alpha_neq);

objectiveFunction = @(paras) multi_objective(paras, Ft_0d1,  P1_exp_0d1, time_0d1,...
                                           Ft_0d3,  P1_exp_0d3, time_0d3,...
                                           Ft_0d03, P1_exp_0d03, time_0d03,...
                                           Ft_0d6,  P1_exp_0d6, time_0d6,...
                                           Ft_1,    P1_exp_1,   time_1,...
                                           num_eq, num_neq, num_rel);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'interior-point', ...
    'MaxIterations', 1000, ...
    'Display', 'iter');

[paras, ~] = lsqnonlin( objectiveFunction, paras0, lb, ub, options);

plot_results(paras, num_eq, num_neq, num_rel,...
                            Ft_0d1,  time_0d1,  lambda1_exp_0d1,  P1_exp_0d1,...
                            Ft_0d3,  time_0d3,  lambda1_exp_0d3,  P1_exp_0d3,...
                            Ft_0d03, time_0d03, lambda1_exp_0d03, P1_exp_0d03,...
                            Ft_0d6,  time_0d6,  lambda1_exp_0d6,  P1_exp_0d6,...
                            Ft_1,    time_1,    lambda1_exp_1,    P1_exp_1);
