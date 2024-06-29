function plot_result(paras, num_eq, num_neq, num_rel, Ft, time, lambda1_exp, P1_exp)
close all;

[mu_eq, alpha_eq, eta, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);
P1_list = get_P_ij_list(1, 2, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft, time);

figure;

ax = axes('Position', [0.1 0.5 0.8 0.4], 'Box', 'on');

plot(ax, lambda1_exp, P1_exp, 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda1_exp, P1_list, 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

x_location = 2.0;
y_location = 0.1;
% print quality of fit
chi = get_quality_of_fit(P1_list, P1_exp);
text_chi = sprintf('$\\chi^2 = %.4g$', chi);
text(x_location, y_location, text_chi, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print MSD
y_location = y_location + 1.0;
MSD = get_MSD(P1_list, P1_exp);
text_MSD = sprintf('$\\mathrm{MSD}=%.4g$', MSD);
text(x_location, y_location, text_MSD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print NMAD
y_location = y_location + 1;
NMAD = get_NMAD(P1_list, P1_exp);
text_NMAD = sprintf('$\\mathrm{NMAD}=%.4g$', NMAD);
text(x_location, y_location, text_NMAD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print parameters
text_mu_eq = cell(length(mu_eq), 1);
text_alpha_eq = cell(length(alpha_eq), 1);
x_location = 1.05;
y_location = -2.5;
for ii = 1:length(mu_eq)
    text_mu_eq{ii} = sprintf('$\\mu_%d^{\\infty} = %.4g$', ii, mu_eq(ii));
    text(x_location, y_location, text_mu_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + 0.25;

    text_alpha_eq{ii} = sprintf('$\\alpha_%d^{\\infty} = %.4g$', ii, alpha_eq(ii));
    text(x_location, y_location, text_alpha_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + 0.25;
end

text_mu_neq = cell(length(mu_neq), length(eta));
text_alpha_neq = cell(length(alpha_neq), length(eta));
text_eta = cell(length(eta), 1);
for ii = 1:length(eta)
    x_location = 1.05;
    y_location = y_location - 1;
    text_eta{ii} = sprintf('$\\eta_{\\mathrm{D}}^%d = %.4g$', ii, eta(ii));
    text(x_location, y_location, text_eta(ii), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    for jj = 1:size(mu_neq,1)
        y_location = y_location - 1;
        text_mu_neq{ii}{jj} = sprintf('$\\mu_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, mu_neq(jj,ii));
        text(x_location, y_location, text_mu_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3;
        text_alpha_neq{ii}{jj} = sprintf('$\\alpha_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, alpha_neq(jj,ii));
        text(x_location, y_location, text_alpha_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3;
    end
end
end