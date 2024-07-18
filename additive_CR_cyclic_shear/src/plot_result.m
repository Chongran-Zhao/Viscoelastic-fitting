function plot_result(paras, num_eq, num_neq, Ft, time, gamma, P_exp)
close all;

[mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d] = paras_to_array(paras, num_eq, num_neq);
P_pre = get_P_ij_list(1, 2, mu_eq, m_eq, n_eq, mu_neq, m_neq, n_neq, eta_d, Ft, time);

figure;
ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');
plot(ax, gamma(1:10:end-1), P_exp(1:10:end-1), 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 10, 'LineStyle', '-', LineWidth=2.0);
hold(ax, 'on');
plot(ax, gamma(1:10:end-1), P_pre(1:10:end-1), 'linewidth', 3.0, 'Color', '#003f5c', 'LineStyle', '-');
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

x_location = 13.5;
y_location = -47;
delta_y = 15;
% print R^2
R_square = get_R_square(P_exp, P_pre);
text_R_square = sprintf('$R^2=%.4g$', R_square);
text(x_location, y_location, text_R_square, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print NMAD
y_location = y_location + delta_y;
NMAD = get_NMAD(P_pre, P_exp);
text_NMAD = sprintf('$\\mathrm{NMAD}=%.4g$', NMAD);
text(x_location, y_location, text_NMAD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print quality of fit
y_location = y_location + delta_y;
chi = get_quality_of_fit(P_pre, P_exp);
text_chi = sprintf('$\\chi^2 = %.4g$', chi);
text(x_location, y_location, text_chi, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
% print MSD
y_location = y_location + delta_y;
MSD = get_MSD(P_pre, P_exp);
text_MSD = sprintf('$\\mathrm{MSD} = %.4g$', MSD);
text(x_location, y_location, text_MSD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print parameters
text_mu_eq = cell(length(mu_eq), 1);
text_m_eq = cell(length(m_eq), 1);
text_n_eq = cell(length(n_eq), 1);

x_location = 0.3;
y_location = -120;
delta_x = 5.0;
delta_y = -30;
for ii = 1:length(mu_eq)
    text_mu_eq{ii} = sprintf('$\\mu_%d^{\\infty} = %.4g$', ii, mu_eq(ii));
    text(x_location, y_location, text_mu_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + delta_x;

    text_m_eq{ii} = sprintf('$m_%d^{\\infty} = %.4g$', ii, m_eq(ii));
    text(x_location, y_location, text_m_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + delta_x;

    text_n_eq{ii} = sprintf('$n_%d^{\\infty} = %.4g$', ii, n_eq(ii));
    text(x_location, y_location, text_n_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + delta_x;
end

text_mu_neq = cell(length(mu_neq), length(eta_d));
text_m_neq = cell(length(m_neq), length(eta_d));
text_n_neq = cell(length(n_neq), length(eta_d));
text_eta = cell(length(eta_d), 1);
x_location = 0.3;
y_location = y_location + delta_y;
for ii = 1:length(eta_d)
    text_eta{ii} = sprintf('$\\eta_{\\mathrm{D}}^%d = %.4g$', ii, eta_d(ii));
    text(x_location, y_location, text_eta(ii), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    y_location = y_location + delta_y;
    for jj = 1:size(mu_neq,1)
        text_mu_neq{ii}{jj} = sprintf('$\\mu_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, mu_neq(jj,ii));
        text(x_location, y_location, text_mu_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + delta_x;

        text_m_neq{ii}{jj} = sprintf('$m_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, m_neq(jj,ii));
        text(x_location, y_location, text_m_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + delta_x;

        text_n_neq{ii}{jj} = sprintf('$n_{\\mathrm{neq}\\:%d}^{%d} = %.4g$', jj, ii, n_neq(jj,ii));
        text(x_location, y_location, text_n_neq{ii}{jj}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + delta_x;

    end
    y_location = y_location + delta_y;
end
end