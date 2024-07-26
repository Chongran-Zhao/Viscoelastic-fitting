clc; clear; close all

addpath("src");

% No.1 shear experimental data
data_1 = readmatrix('../exp_data_shear/monotonic_shear_1.csv');
time_1 = data_1(:,1);
gamma_1 = data_1(:,4);

% No.2 shear experimental data
data_2 = readmatrix('../exp_data_shear/monotonic_shear_0d1.csv');
time_2 = data_2(:,1);
gamma_2 = data_2(:,4);

% No.3 shear experimental data
data_3 = readmatrix('../exp_data_shear/monotonic_shear_0d01.csv');
time_3 = data_3(:,1);
gamma_3 = data_3(:,4);

% No.4 shear experimental data
data_4 = readmatrix('../exp_data_shear/monotonic_shear_0d05.csv');
time_4 = data_4(:,1);
gamma_4 = data_4(:,4);

figure;
ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');
plot(ax, time_1, gamma_1, 'Color', '#003f5c', 'Marker', 'o', 'MarkerFaceColor', '#003f5c', 'MarkerSize', 8, 'LineStyle', '-', 'LineWidth', 3);
hold(ax, 'on');
plot(ax, time_2, gamma_2, 'Color', '#58508d', 'Marker', 'o', 'MarkerFaceColor', '#58508d', 'MarkerSize', 8, 'LineStyle', '-', 'LineWidth', 3);
hold(ax, 'on');
plot(ax, time_3, gamma_3, 'Color', '#bc5090', 'Marker', 'o', 'MarkerFaceColor', '#bc5090', 'MarkerSize', 8, 'LineStyle', '-', 'LineWidth', 3);
hold(ax, 'on');
plot(ax, time_4, gamma_4, 'Color', 'r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'LineStyle', '-', 'LineWidth', 3);

xlabel(ax, 'Time', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');
ylabel(ax, 'Shear Stretch', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');

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
set(ax, 'XScale', 'log');

l = legend(ax, '$\dot{\gamma} = 1\:\mathrm{s}^{-1}$',...
               '$\dot{\gamma} = 0.1\:\mathrm{s}^{-1}$',...
               '$\dot{\gamma} = 0.01\:\mathrm{s}^{-1}$',...
               '$\dot{\gamma} = 0.05\:\mathrm{s}^{-1}$',...
               'location', 'northwest', 'Orientation', 'horizontal');
set(l, 'interpreter', 'latex', 'fontsize', 25, 'box', 'off', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 1);

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
