clc;clear;close all
addpath('src/')
% A = rand(3,3,3,3);
% for ii = 1:3
%     for jj = 1:3
%         for kk = 1:3
%             for ll = 1:3
%                 A(ii,jj,kk,ll) = A(jj,ii,kk,ll);
%             end
%         end
%     end
% end
% for ii = 1:3
%     for jj = 1:3
%         for kk = 1:3
%             for ll = 1:3
%                 A(ii,jj,kk,ll) = A(ii,jj,ll,kk);
%             end
%         end
%     end
% end
% X = rand(3,3);
% for ii = 1:3
%     for jj = 1:3
%         X(ii,jj) = X(jj,ii);
%     end
% end
% format long
% X
% B = contract(A,X);
% X = solve_AB(A,B)
data = readmatrix('../exp_data_shear/monotonic_shear_0d1.csv');
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
mu_neq = [1.0];
m_neq = [1.0];
n_neq = [1.0];
eta_d = [1.0];
% mu_neq = [1];
% m_neq = [3.891602608546285];
% n_neq = [5.564963537668532];
% eta_d = [99.8926];


out = get_Gamma_t(mu_neq, m_neq, n_neq, eta_d, Ft, time)