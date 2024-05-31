clc; clear; close all
fid = fopen('data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

stress = data{1}';
strain = data{2}';
time = data{3}';

Ft = zeros(3,3,length(strain));
Ft(1,1,:) = strain(:);
Ft(2,2,:) = (strain(:)).^(-0.5);
Ft(3,3,:) = (strain(:)).^(-0.5);

xi_neq = [1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0];
be = get_be(time, xi_neq, Ft);











