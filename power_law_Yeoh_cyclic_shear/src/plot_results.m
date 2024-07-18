function plot_results(paras,...
    time_1, gamma_1, P_exp_1,...
    time_2, gamma_2, P_exp_2,...
    time_3, gamma_3, P_exp_3)

Ft_1 = zeros(3,3,length(time_1));
Ft_1(1,1,:) = 1.0;
Ft_1(2,2,:) = 1.0;
Ft_1(3,3,:) = 1.0;
Ft_1(1,2,:) = gamma_1(:);

Ft_2 = zeros(3,3,length(time_2));
Ft_2(1,1,:) = 1.0;
Ft_2(2,2,:) = 1.0;
Ft_2(3,3,:) = 1.0;
Ft_2(1,2,:) = gamma_2(:);

Ft_3 = zeros(3,3,length(time_3));
Ft_3(1,1,:) = 1.0;
Ft_3(2,2,:) = 1.0;
Ft_3(3,3,:) = 1.0;
Ft_3(1,2,:) = gamma_3(:);

[xi_eq, xi_neq, tau_hat, power_m] = paras_to_array(paras);

P_pre_1 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_1, time_1);
P_pre_2 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_2, time_2);
P_pre_3 = get_P_ij_list(1, 2, xi_eq, xi_neq, tau_hat, power_m, Ft_3, time_3);

figure;

ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');

plot(ax, gamma_1, P_exp_1, 'Color', '#003f5c', 'Marker', 'o', 'MarkerFaceColor', '#003f5c', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, gamma_1, P_pre_1, 'linewidth', 3.0, 'Color', '#003f5c', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, gamma_2, P_exp_2, 'Color', '#58508d', 'Marker', 'o', 'MarkerFaceColor', '#58508d', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, gamma_2, P_pre_2, 'linewidth', 3.0, 'Color', '#58508d', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, gamma_3, P_exp_3, 'Color', '#bc5090', 'Marker', 'o', 'MarkerFaceColor', '#bc5090', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, gamma_3, P_pre_3, 'linewidth', 3.0, 'Color', '#bc5090', 'LineStyle', '-');

xlabel(ax, 'Stretch', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');
ylabel(ax, 'Nominal stress', 'interpreter', 'latex', 'FontSize', 30, 'FontWeight', 'bold', 'FontName', 'Helvetica');

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

l = legend(ax, 'exp-1', 'fit-1',...
    'exp-0d1', 'fit-0d1',...
    'exp-0d01', 'fit-0d01',...
    'location', 'northwest', 'Orientation', 'horizontal');
set(l, 'interpreter', 'latex', 'fontsize', 25, 'box', 'off', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 2);

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

x_location = 8.7;
y_location = 0.1;
delta_y = 14;
% print R^2
R_square = (get_R_square(P_exp_1, P_pre_1) + get_R_square(P_exp_2, P_pre_2) + get_R_square(P_exp_3, P_pre_3)) / 3.0;
text_R_square = sprintf('$R^2=%.4g$', R_square);
text(x_location, y_location, text_R_square, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print NMAD
y_location = y_location + delta_y;
NMAD = (get_NMAD(P_pre_1, P_exp_1) + get_NMAD(P_pre_2, P_exp_2) + get_NMAD(P_pre_3, P_exp_3)) / 3.0;
text_NMAD = sprintf('$\\mathrm{NMAD}=%.4g$', NMAD);
text(x_location, y_location, text_NMAD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print quality of fit
y_location = y_location + delta_y;
chi = get_quality_of_fit(P_pre_1, P_exp_1)...
    + get_quality_of_fit(P_pre_2, P_exp_2)...
    + get_quality_of_fit(P_pre_3, P_exp_3);
text_chi = sprintf('$\\chi^2 = %.4g$', chi);
text(x_location, y_location, text_chi, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
% print MSD
y_location = y_location + delta_y;
MSD = get_MSD(P_pre_1, P_exp_1);
MSD = MSD + get_MSD(P_pre_2, P_exp_2);
MSD = MSD + get_MSD(P_pre_3, P_exp_3);
MSD = MSD / 3.0;
text_MSD = sprintf('$\\mathrm{MSD} = %.4g$', MSD);
text(x_location, y_location, text_MSD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');


% print parameters
text_xi_eq = cell(length(xi_eq), 1);
x_location = 1.0;
y_location = -60;
delta_y = -30;
delta_x = 3.0;
for ii = 1:length(xi_eq)
    text_xi_eq{ii} = sprintf('$C_%d^{\\infty} = %.4g$', ii, xi_eq(ii));
    text(x_location, y_location, text_xi_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + delta_x;
end

y_location = y_location + delta_y;
x_location = 1.0;
text_tau_hat = sprintf('$\\hat{\\tau} = %.4g$', tau_hat);
text(x_location, y_location, text_tau_hat, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
x_location = x_location + delta_x;
text_power_m = sprintf('$m = %.4g$', power_m);
text(x_location, y_location, text_power_m, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

y_location = y_location + delta_y;
x_location = 1.0;
text_xi_neq = cell(length(xi_neq), 1);
for ii = 1:length(xi_neq)
    text_xi_neq{ii} = sprintf('$C_{\\mathrm{neq}\\:%d} = %.4g$', ii, xi_neq(ii));
    text(x_location, y_location, text_xi_neq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + delta_x;
end
end