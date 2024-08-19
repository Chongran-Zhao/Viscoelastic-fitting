function plot_result(paras, time, gamma, P_exp, mode)
close all;
Ft = zeros(3,3,length(time));
Ft(1,1,:) = 1.0;
Ft(2,2,:) = 1.0;
Ft(3,3,:) = 1.0;
Ft(1,2,:) = gamma(:);
[xi_eq, xi_neq, C1, C2, tau_hat, power_m] = paras_to_array(paras);
P_pre = get_P_ij_list(1, 2, xi_eq, xi_neq, C1, C2, tau_hat, power_m, Ft, time);

switch mode
    case 1
        figure;
        ax = axes('Position', [0.1 0.5 0.8 0.4], 'Box', 'on');
        plot(ax, gamma, P_exp, 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
        hold(ax, 'on');
        plot(ax, gamma, P_pre, 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

        x_location = 6.1;
        y_location = 0.1;
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
        text_xi_eq = cell(length(xi_eq), 1);
        x_location = min(gamma) + 0.1 * max(gamma);
        y_location = min(P_exp) - 0.4 * max(P_exp);
        for ii = 1:length(xi_eq)
            text_xi_eq{ii} = sprintf('$C_%d^{\\infty} = %.4g$', ii, xi_eq(ii));
            text(x_location, y_location, text_xi_eq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_tau_hat = sprintf('$\\hat{\\tau} = %.4g$', tau_hat);
        text(x_location, y_location, text_tau_hat, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3 * max(gamma);
        text_power_m = sprintf('$m = %.4g$', power_m);
        text(x_location, y_location, text_power_m, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_xi_neq = cell(length(xi_neq), 1);
        for ii = 1:size(xi_neq, 2)
            text_xi_neq{ii} = sprintf('$C_{\\mathrm{neq}\\:%d} = %.4g$', ii, xi_neq(ii));
            text(x_location, y_location, text_xi_neq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end
    case 0.1
        figure;
        ax = axes('Position', [0.1 0.5 0.8 0.4], 'Box', 'on');
        plot(ax, gamma(1:2:end-1), P_exp(1:2:end-1), 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
        hold(ax, 'on');
        plot(ax, gamma(1:2:end-1), P_pre(1:2:end-1), 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

        x_location = 8.5;
        y_location = 0.1;
        delta_y = 12;
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
        text_xi_eq = cell(length(xi_eq), 1);
        x_location = min(gamma) + 0.1 * max(gamma);
        y_location = min(P_exp) - 0.4 * max(P_exp);
        for ii = 1:length(xi_eq)
            text_xi_eq{ii} = sprintf('$C_%d^{\\infty} = %.4g$', ii, xi_eq(ii));
            text(x_location, y_location, text_xi_eq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_tau_hat = sprintf('$\\hat{\\tau} = %.4g$', tau_hat);
        text(x_location, y_location, text_tau_hat, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3 * max(gamma);
        text_power_m = sprintf('$m = %.4g$', power_m);
        text(x_location, y_location, text_power_m, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_xi_neq = cell(length(xi_neq), 1);
        for ii = 1:length(xi_neq)
            text_xi_neq{ii} = sprintf('$C_{\\mathrm{neq}\\:%d} = %.4g$', ii, xi_neq(ii));
            text(x_location, y_location, text_xi_neq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end
    case 0.01
        figure;
        ax = axes('Position', [0.1 0.5 0.8 0.4], 'Box', 'on');
        plot(ax, gamma(1:2:end-1), P_exp(1:2:end-1), 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
        hold(ax, 'on');
        plot(ax, gamma(1:2:end-1), P_pre(1:2:end-1), 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

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

        x_location = 8.5;
        y_location = 0.1;
        delta_y = 6;
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
        text_xi_eq = cell(length(xi_eq), 1);
        x_location = min(gamma) + 0.1 * max(gamma);
        y_location = min(P_exp) - 0.4 * max(P_exp);
        for ii = 1:length(xi_eq)
            text_xi_eq{ii} = sprintf('$C_%d^{\\infty} = %.4g$', ii, xi_eq(ii));
            text(x_location, y_location, text_xi_eq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_tau_hat = sprintf('$\\hat{\\tau} = %.4g$', tau_hat);
        text(x_location, y_location, text_tau_hat, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
        x_location = x_location + 0.3 * max(gamma);
        text_power_m = sprintf('$m = %.4g$', power_m);
        text(x_location, y_location, text_power_m, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'Interpreter', 'latex', ...
            'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');

        y_location = y_location - 0.2 * max(P_exp);
        x_location = min(gamma) + 0.1 * max(gamma);
        text_xi_neq = cell(length(xi_neq), 1);
        for ii = 1:length(xi_neq)
            text_xi_neq{ii} = sprintf('$C_{\\mathrm{neq}\\:%d} = %.4g$', ii, xi_neq(ii));
            text(x_location, y_location, text_xi_neq{ii}, ...
                'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'bottom', ...
                'Interpreter', 'latex', ...
                'FontSize', 25, 'FontWeight', 'bold', 'Color', 'k', 'FontName', 'Helvetica');
            x_location = x_location + 0.3 * max(gamma);
        end
end