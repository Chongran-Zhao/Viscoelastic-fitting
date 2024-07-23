clc; clear; close all

addpath("src");
data = readmatrix('../exp_data_cyclic_shear_raw/400.xlsx');
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
num_eq = 1;
num_neq = 1;
num_mullins = 3;
num_samples = 10;

[samples, lb, ub] = array_to_paras(num_eq, num_neq, num_mullins, num_samples);
objectiveFunction = @(paras) objective(paras, Ft, P_exp, time, num_eq, num_neq);
options = optimoptions('lsqnonlin', ...
    'Algorithm', 'trust-region-reflective', ...
    'MaxIterations', 1000, ...
    'TolFun', 1e-10, ...
    'TolX', 1e-10, ...
    'Display', 'iter-detailed', ...
    'MaxFunctionEvaluations', 5000,  ...
    'PlotFcn', 'optimplotfval');

poolobj = gcp('nocreate');

if isempty(poolobj)
    disp('没有并行池，创建一个');
    parpool; % 创建一个默认大小的并行池
else
    disp(['当前并行池的工作器数为：', num2str(poolobj.NumWorkers)]);
end
result = [];
res_norm = [];
parfor ii = 1:length(num_samples)
    samples(ii,:)
    disp(['正在处理 ', num2str(ii), ' 号任务']);
    [paras, resnorm] = lsqnonlin( objectiveFunction, samples(ii,:), lb, ub, options);
    result = [result; paras];
    res_norm = [res_norm, resnorm];
end
delete(gcp('nocreate'));
% [samples, lb, ub] = array_to_paras(num_eq, num_neq, num_mullins, num_samples);
% plot_result(paras, num_eq, num_neq, Ft, time, P_exp, 3);
% print(gcf, '-djpeg', 'fig_cyclic_shear_400.jpg');