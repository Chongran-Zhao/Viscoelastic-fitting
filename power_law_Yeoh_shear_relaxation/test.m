clc; clear; close all

addpath("src");
data = readmatrix('~/Downloads/shear_relaxation_5.xlsx');
time = data(:,1);
P_exp = data(:,4);
gamma = data(:,5);;

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

xi_eq = [1.0, 1.0, 1.0];
xi_neq = [1.0, 1.0, 1.0];
C1 = [1.0];
C2 = [-0.1];
tau_hat = [1.0];
power_m = [1.0];

out =  get_be_t(time, xi_neq, C1, C2, tau_hat, power_m , Ft)