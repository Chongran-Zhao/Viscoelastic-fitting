clc; clear; close all

% No.1 shear experimental data
data_1 = readmatrix('../exp-data/loading_1d5_unloading_0d03.xlsx');
P_exp_1 = data_1(:,3);
lambda_1 = data_1(:,2);

% No.2 shear experimental data
data_2 = readmatrix('../exp-data/loading_2d0_unloading_0d03.xlsx');
P_exp_2 = data_2(:,3);
lambda_2 = data_2(:,2);

% No.3 shear experimental data
data_3 = readmatrix('../exp-data/loading_2d5_unloading_0d03.xlsx');
P_exp_3 = data_3(:,3);
lambda_3 = data_3(:,2);

% No.3 shear experimental data
% data_4 = readmatrix('../exp-data/loading_3d0_unloading_0d01.xlsx');
% P_exp_4 = data_4(:,3);
% lambda_4 = data_4(:,2);

figure;
ax = axes('Box', 'on');
% ax = axes('Position', [0.0 0.1 0.8 0.8], 'Box', 'on');
plot(ax, lambda_1, P_exp_1, 'Color', '#003f5c', 'Marker', 'o', 'MarkerFaceColor', '#003f5c', 'MarkerSize', 8);
hold(ax, 'on');
plot(ax, lambda_2, P_exp_2, 'Color', '#58508d', 'Marker', 'o', 'MarkerFaceColor', '#58508d', 'MarkerSize', 8);
hold(ax, 'on');
plot(ax, lambda_3, P_exp_3, 'Color', '#bc5090', 'Marker', 'o', 'MarkerFaceColor', '#bc5090', 'MarkerSize', 8);
% hold(ax, 'on');
% plot(ax, lambda_4, P_exp_4, 'Color', 'b', 'Marker', 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 8);
xlabel(ax, 'Tensile Stretch', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');
ylabel(ax, 'Nominal Stress (kPa)', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');
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

l = legend(ax, '$\dot{\lambda} = 0.03\:\mathrm{s}^{-1}$',...
               '$\dot{\lambda} = 0.03\:\mathrm{s}^{-1}$' ,...
               '$\dot{\lambda} = 0.03\:\mathrm{s}^{-1}$' ,...
               'location', 'northwest', 'Orientation', 'horizontal');
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
print(gcf, '-djpeg', 'exp_points.jpg');