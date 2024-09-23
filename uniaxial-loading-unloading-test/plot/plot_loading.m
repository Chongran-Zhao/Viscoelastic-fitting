clc; clear; close all

% No.1 shear experimental data
data_1 = readmatrix('../exp-data/loading_1d5_unloading_0d01.xlsx');
time_1 = data_1(:,1);
lambda_1 = data_1(:,2);

% No.2 shear experimental data
data_2 = readmatrix('../exp-data/loading_1d5_unloading_0d03.xlsx');
time_2 = data_2(:,1);
lambda_2 = data_2(:,2);

% No.3 shear experimental data
data_3 = readmatrix('../exp-data/loading_1d5_unloading_0d05.xlsx');
time_3 = data_3(:,1);
lambda_3 = data_3(:,2);

% No.4 shear experimental data
% data_4 = readmatrix('../exp-data/loading_3d0_unloading_0d05.xlsx');
% time_4 = data_4(:,1);
% lambda_4 = data_4(:,2);

figure;
ax = axes('Box', 'on');
% ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');
plot(ax, time_1, lambda_1, 'Color', '#003f5c', 'Marker', 'o', 'MarkerFaceColor', '#003f5c', 'MarkerSize', 8);
hold(ax, 'on');
plot(ax, time_2, lambda_2, 'Color', '#58508d', 'Marker', 'o', 'MarkerFaceColor', '#58508d', 'MarkerSize', 8);
hold(ax, 'on');
plot(ax, time_3, lambda_3, 'Color', '#bc5090', 'Marker', 'o', 'MarkerFaceColor', '#bc5090', 'MarkerSize', 8);
% hold(ax, 'on');
% plot(ax, time_4, lambda_4, 'Color', 'b', 'Marker', 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 8);

xlabel(ax, 'Time (s)', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');
ylabel(ax, 'Stretch', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');

set(ax, 'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YGrid', 'on', ...
    'XGrid', 'on', ...
    'XColor', [0 0 0], ...
    'YColor', [0 0 0], ...
    'LineWidth', 2, ...
    'FontSize', 25, 'FontWeight', 'bold');

l = legend(ax, '$\dot{\gamma} = 0.01\:\mathrm{s}^{-1}$',...
               '$\dot{\gamma} = 0.03\:\mathrm{s}^{-1}$' ,...
               '$\dot{\gamma} = 0.05\:\mathrm{s}^{-1}$',...
               'location', 'northeast', 'Orientation', 'horizontal');
set(l, 'interpreter', 'latex', 'fontsize', 35, 'box', 'off', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 1);

X = 40.0;
Y = 40.0;
xMargin = 3;
yMargin = 3;
xSize = X - 2 * xMargin;
ySize = Y - 2 * yMargin;
set(gcf, 'Units', 'centimeters', 'Position', [5 5 xSize ySize]);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [X Y]);
set(gcf, 'PaperPosition', [xMargin yMargin xSize ySize]);
set(gcf, 'PaperOrientation', 'portrait');
print(gcf, '-djpeg', 'loading.jpg');