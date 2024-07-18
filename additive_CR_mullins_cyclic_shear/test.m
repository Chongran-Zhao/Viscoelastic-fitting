clc; clear; close all

addpath("src");
data = readmatrix('../cyclic_shear_part.xlsx');
time = data(:,1);
P_exp = data(:,2);
gamma = data(:,3);

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

% parameters
mu_eq = [1.0];
m_eq = [1.0];
n_eq = [1.0];

mu_neq = [1.0];
m_neq = [1.0];
n_neq = [1.0];
eta_d = [100.0];

out = get_alpha_t(mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time);