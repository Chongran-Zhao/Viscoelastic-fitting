clc; clear; close all

addpath("src");
data = readmatrix('../exp_data_cyclic_shear_raw/800.xlsx');
time = data(:,1);
P_exp = data(:,3);
gamma = data(:,4);

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

% The length of mu_eq and alpha_eq should be the same
% mu_eq = [mu1_eq, mu2_eq]
% alpha_eq = [alpha1_eq, alpha2_eq]
mu_eq = [1.0, 1.0, 1.0];
alpha_eq = [1.0, 1.0, 1.0];

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

m = [1.0];
r = [100.0];
beta = [10.0];


out = get_be_t(time, mu_neq, alpha_neq, eta, Ft);