clc; clear; close all

addpath("src");
data = readmatrix('../exp_data_var_sym_shear_raw/100.xlsx');
time = data(:,1);
P_exp = data(:,3);
gamma = data(:,4);

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);

% parameters
mu_eq = [1.0];
m_eq = [2.5];
n_eq = [1.0];

mu_neq = [1.0];
m_neq = [2.5];
n_neq = [1.0];
eta_d = [1.0];

m = [1.0];
r = [100.0];
beta = [0.1];

Ct = zeros(size(Ft));

for ii = 1:length(time)
    Ct(:,:,ii) = Ft(:,:,ii)' * Ft(:,:,ii);
    [V, D] = eig(Ct(:,:,ii))
end