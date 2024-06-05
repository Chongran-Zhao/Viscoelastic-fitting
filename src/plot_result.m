function plot_result(paras, num_eq, num_neq, num_rel, Ft, time, lambda1_exp, P1_exp)
close all
    [mu_eq, alpha_eq, eta, mu_neq, alpha_neq] = paras_to_array(paras, num_eq, num_neq, num_rel);

    P1_list = get_P1_list(mu_eq, alpha_eq, mu_neq, alpha_neq, eta, Ft, time);
    plot(lambda1_exp, P1_exp, 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 12, 'LineStyle', 'none');
    hold on
    plot(lambda1_exp, P1_list, 'linewidth', 3.0, 'Color', '#ffa600', 'LineStyle', '-');

    hXLabel = xlabel('Stretch', 'interpreter', 'latex');
    hYLabel = ylabel('Nominal stress', 'interpreter', 'latex');

    set(gca, 'Box', 'on', 'TickDir', 'out', ...
        'TickLength', [.02 .02], ...
        'XMinorTick', 'on', ...
        'YMinorTick', 'on', ...
        'YGrid', 'on', ...
        'XGrid', 'on', ...
        'XColor', [0 0 0], ...
        'YColor', [0 0 0], ...
        'LineWidth', 2);
    set(gca, 'FontSize', 25, 'FontWeight', 'bold');
    set([hXLabel, hYLabel], 'FontName', 'Helvetica', 'FontSize', 30, 'FontWeight', 'bold');

    X = 40.0;
    Y = X * 0.6;
    xMargin = 3;
    yMargin = 3;
    xSize = X - 2 * xMargin;
    ySize = Y - 2 * yMargin;
    set(gcf, 'Units', 'centimeters', 'Position', [5 5 xSize ySize]);
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf, 'PaperSize', [X Y]);
    set(gcf, 'PaperPosition', [xMargin yMargin xSize ySize]);
    set(gcf, 'PaperOrientation', 'portrait');

    l = legend('experiment', 'fitting');
    set(l, 'interpreter', 'latex', 'fontsize', 25, 'box', 'off', 'location', 'northwest', 'Orientation', ...
        'horizontal', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 4);
    l.ItemTokenSize = [45, 45];
end