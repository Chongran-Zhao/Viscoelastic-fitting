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

xi_eq = [1.0, 1.0e-1, 1.0e-2];
xi_neq = [1.0, 1.0e-1, 1.0e-2];
tau_hat = 1.0e2;
power_m = 1.0;

out = get_be_t(time, xi_neq, tau_hat, power_m , Ft)