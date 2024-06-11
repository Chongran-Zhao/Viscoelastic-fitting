clc; clear; close all

addpath("src");

fid = fopen('../exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp = data{1}';
lambda1_exp = data{2}';
time = data{3}';

% Uniaxial tension experimental case
Ft = zeros(3,3,length(time));
Ft(1,1,:) = lambda1_exp(:);
Ft(2,2,:) = lambda1_exp(:).^(-0.5);
Ft(3,3,:) = lambda1_exp(:).^(-0.5);

% parameters
mu = 1.0;
m = 1.0;
n = 1.0;
eta_d = 1.0;
out = get_Gamma_t(mu, m, n, eta_d, Ft, time)

