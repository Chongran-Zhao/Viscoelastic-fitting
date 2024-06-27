function plot_result(paras, num_eq, num_neq, Ft, time, gamma, P_shear_exp)
close all;

[xi_eq, xi_neq, eta_d] = paras_to_array(paras, num_eq, num_neq);
P_shear_list = get_P_ij_list(1 ,2, xi_eq, xi_neq, eta_d, Ft, time);

figure;

ax = axes('Position', [0.1 0.5 0.8 0.4], 'Box', 'on');

plot(ax, gamma, P_shear_exp, 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, gamma, P_shear_list, 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

l = legend(ax, 'experiment', 'fitting', 'location', 'northwest', 'Orientation', 'horizontal');
set(l, 'interpreter', 'latex', 'fontsize', 25, 'box', 'off', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 4);

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

x_location = 8.6;
y_location = 0.5;
% print quality of fit
chi = get_quality_of_fit(P_shear_list, P_shear_exp);
text_chi = sprintf('$\\chi^2 = %.4g$', chi);
text(x_location, y_location, text_chi, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print MSD
y_location = y_location + 10;
MSD = get_MSD(P_shear_list, P_shear_exp);
text_MSD = sprintf('$\\mathrm{MSD} = %.4g$', MSD);
text(x_location, y_location, text_MSD, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print parameters
text_xi_eq = cell(length(xi_eq), 1);
x_location = min(gamma) + 0.1 * max(gamma);
y_location = min(P_shear_exp) - 0.4 * max(P_shear_exp);
for ii = 1:length(xi_eq)
    text_xi_eq{ii} = sprintf('$C_%d^{\\infty} = %.4g$', ii, xi_eq(ii));
    text(x_location, y_location, text_xi_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + 0.3 * max(gamma);
end

text_xi_neq = cell(length(xi_neq), length(eta_d));
text_eta = cell(length(eta_d), 1);
y_location = y_location - 0.2 * max(P_shear_exp);
for ii = 1:length(eta_d)
    x_location = min(gamma) + 0.1 * max(gamma);
    text_eta{ii} = sprintf('$\\eta_{\\mathrm{D}}^%d = %.4g$', ii, eta_d(ii));
    text(x_location, y_location, text_eta(ii), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    y_location = y_location - 0.2 * max(P_shear_exp);
    for jj = 1:size(xi_neq,2)
        text_xi_neq{ii}{jj} = sprintf('$C_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, xi_neq(ii,jj));
        text(x_location, y_location, text_xi_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3 * max(gamma);
    end
end
end