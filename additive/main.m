clc; clear; close all

addpath("src");

fid = fopen('../exp_data_UT/data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

P1_exp = data{1}';
lambda1_exp = data{2}';
time = data{3}';

% Uniaxial tension experimental case
Ft = zeros(3,3,1);
Ft(1,1,1) = lambda1_exp(:);
Ft(2,2,1) = lambda1_exp(:).^(-0.5);
Ft(3,3,1) = lambda1_exp(:).^(-0.5);

