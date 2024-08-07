function plot_results(paras, num_eq, num_neq, num_rel,...
                            time_1, lambda_exp_1, P_exp_1,...
                            time_2, lambda_exp_2, P_exp_2,...
                            time_3, lambda_exp_3, P_exp_3,...
                            time_4, lambda_exp_4, P_exp_4,...
                            time_5, lambda_exp_5, P_exp_5)

Ft_1 = zeros(3,3,length(lambda_exp_1));
Ft_1(1,1,:) = lambda_exp_1(:);
Ft_1(2,2,:) = lambda_exp_1(:).^(-0.5);
Ft_1(3,3,:) = lambda_exp_1(:).^(-0.5);

Ft_2 = zeros(3,3,length(lambda_exp_2));
Ft_2(1,1,:) = lambda_exp_2(:);
Ft_2(2,2,:) = lambda_exp_2(:).^(-0.5);
Ft_2(3,3,:) = lambda_exp_2(:).^(-0.5);

Ft_3 = zeros(3,3,length(lambda_exp_3));
Ft_3(1,1,:) = lambda_exp_3(:);
Ft_3(2,2,:) = lambda_exp_3(:).^(-0.5);
Ft_3(3,3,:) = lambda_exp_3(:).^(-0.5);

Ft_4 = zeros(3,3,length(lambda_exp_4));
Ft_4(1,1,:) = lambda_exp_4(:);
Ft_4(2,2,:) = lambda_exp_4(:).^(-0.5);
Ft_4(3,3,:) = lambda_exp_4(:).^(-0.5);

Ft_5 = zeros(3,3,length(lambda_exp_5));
Ft_5(1,1,:) = lambda_exp_5(:);
Ft_5(2,2,:) = lambda_exp_5(:).^(-0.5);
Ft_5(3,3,:) = lambda_exp_5(:).^(-0.5);

[mu_eq, alpha_eq, eta, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);
P_pre_1 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft_1, time_1);
P_pre_2 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft_2, time_2);
P_pre_3 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft_3, time_3);
P_pre_4 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft_4, time_4);
P_pre_5 = get_P_ij_list(1, 1, mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft_5, time_5);

figure;

ax = axes('Position', [0.1 0.6 0.8 0.4], 'Box', 'on');

plot(ax, lambda_exp_1(1:50:end), P_exp_1(1:50:end), 'Color', '#003f5c', 'Marker', 'o', 'MarkerFaceColor', '#003f5c', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda_exp_1, P_pre_1, 'linewidth', 3.0, 'Color', '#003f5c', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, lambda_exp_2(1:10:end), P_exp_2(1:10:end), 'Color', '#58508d', 'Marker', 'o', 'MarkerFaceColor', '#58508d', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda_exp_2, P_pre_2, 'linewidth', 3.0, 'Color', '#58508d', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, lambda_exp_3(1:100:end), P_exp_3(1:100:end), 'Color', '#bc5090', 'Marker', 'o', 'MarkerFaceColor', '#bc5090', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda_exp_3, P_pre_3, 'linewidth', 3.0, 'Color', '#bc5090', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, lambda_exp_4(1:5:end), P_exp_4(1:5:end), 'Color', '#ff6361', 'Marker', 'o', 'MarkerFaceColor', '#ff6361', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda_exp_4, P_pre_4, 'linewidth', 3.0, 'Color', '#ff6361', 'LineStyle', '-');
hold(ax, 'on');
plot(ax, lambda_exp_5(1:3:end), P_exp_5(1:3:end), 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
hold(ax, 'on');
plot(ax, lambda_exp_5, P_pre_5, 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

l = legend(ax, 'exp-0d1', 'fit-0d1',...
               'exp-0d3', 'fit-0d3',...
               'exp-0d03', 'fit-0d03',...
               'exp-0d6', 'fit-0d6',...
               'exp-1', 'fit-1',...
               'location', 'northwest', 'Orientation', 'horizontal');
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

x_location = 2.05;
y_location = 0.1;
delta_y = 0.8;
% print R^2
R_square = (get_R_square(P_exp_1, P_pre_1) + get_R_square(P_exp_2, P_pre_2) + get_R_square(P_exp_3, P_pre_3) + + get_R_square(P_exp_4, P_pre_4) + + get_R_square(P_exp_5, P_pre_5)) / 5.0;
text_R_square = sprintf('$R^2=%.4g$', R_square);
text(x_location, y_location, text_R_square, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print NMAD
y_location = y_location + delta_y;
NMAD = (get_NMAD(P_pre_1, P_exp_1) + get_NMAD(P_pre_2, P_exp_2) + get_NMAD(P_pre_3, P_exp_3) + get_NMAD(P_pre_4, P_exp_4) + get_NMAD(P_pre_5, P_exp_5)) / 5.0;
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
    + get_quality_of_fit(P_pre_3, P_exp_3)...
    + get_quality_of_fit(P_pre_4, P_exp_4)...
    + get_quality_of_fit(P_pre_5, P_exp_5);
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
MSD = MSD + get_MSD(P_pre_4, P_exp_4);
MSD = MSD + get_MSD(P_pre_5, P_exp_5);
MSD = MSD / 5.0;
text_MSD = sprintf('$\\mathrm{MSD} = %.4g$', MSD);
text(x_location, y_location, text_MSD, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Interpreter', 'latex', ...
    'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

% print parameters
text_mu_eq = cell(length(mu_eq), 1);
text_alpha_eq = cell(length(alpha_eq), 1);
x_location = 1.1;
for ii = 1:length(mu_eq)
    text_mu_eq{ii} = sprintf('$\\mu_%d^{\\infty} = %.4g$', ii, mu_eq(ii));
    text(x_location, -3.0, text_mu_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + 0.3;

    text_alpha_eq{ii} = sprintf('$\\alpha_%d^{\\infty} = %.4g$', ii, alpha_eq(ii));
    text(x_location, -3.0, text_alpha_eq{ii}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    x_location = x_location + 0.3;
end

text_mu_neq = cell(length(mu_neq), length(eta));
text_alpha_neq = cell(length(alpha_neq), length(eta));
text_eta = cell(length(eta), 1);
y_location = -4.0;
for ii = 1:length(eta)
    x_location = 1.1;
    text_eta{ii} = sprintf('$\\eta_{\\mathrm{D}}^%d = %.4g$', ii, eta(ii));
    text(x_location, y_location, text_eta(ii), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'Interpreter', 'latex', ...
        'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
    y_location = y_location - 1.0;
    for jj = 1:size(mu_neq,1)
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
    y_location = y_location - 1.0;
end
end