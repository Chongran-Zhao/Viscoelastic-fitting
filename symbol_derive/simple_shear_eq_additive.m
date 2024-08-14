clc;
clear;
close all
syms k m n
F = [1, k, 0; 0, 1, 0; 0, 0, 1];
C = transpose(F) * F;
eigenvalues = eig(C);
C1 = eigenvalues(1);
C2 = eigenvalues(2);
C3 = eigenvalues(3);
lambda1 = sqrt(C1);
lambda2 = sqrt(C2);
lambda3 = sqrt(C3);

matrix = C - C1 * eye(size(C));
N1 = null(matrix);
if ~isempty(N1)
    N1 = N1(:, 1);
    norm = sqrt(N1(1)^2 + N1(2)^2 + N1(3)^2);
    N1 = N1 / norm;
    N1 = simplify(N1);
end

matrix = C - C2 * eye(size(C));
N2 = null(matrix);
if ~isempty(N2)
    N2 = N2(:, 1);
    norm = sqrt(N2(1)^2 + N2(2)^2 + N2(3)^2);
    N2 = N2 / norm;
    N2 = simplify(N2);
end

matrix = C - C3 * eye(size(C));
N3 = null(matrix);
if ~isempty(N3)
    N3 = N3(:, 1);
    norm = sqrt(N3(1)^2 + N3(2)^2 + N3(3)^2);
    N3 = N1 / norm;
    N3 = simplify(N3);
end

Sa = @(lambda) 1/(m+n)^2 * 1/lambda * (lambda^m - lambda^(-n)) * (m*lambda^(m-1) + n*lambda^(-n-1));
S1 = Sa(lambda1);
S2 = Sa(lambda2);
S3 = Sa(lambda3);

S = S1 .* kron(transpose(N1), N1);
S = S + S2 .* kron(transpose(N2), N2);
S = S + S3 .* kron(transpose(N3), N3);

P = F*S;

P_12 = P(1,2);

data = readmatrix('../exp_data_var_sym_shear_raw/100.xlsx');
% time = data(:,1);
% P_exp = data(:,3);
gamma = data(:,4);
P = zeros(length(gamma), 1);
for ii = 1:length(gamma)
    P(ii) = subs(P_12, {k, m, n}, {gamma(ii), -0.3, -0.3});
end
ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');
plot(ax, gamma, P, 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 10, 'LineStyle', '-', LineWidth=2.0);
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

% l = legend(ax, 'experiment', 'fitting', 'location', 'northwest', 'Orientation', 'horizontal');
% set(l, 'interpreter', 'latex', 'fontsize', 25, 'box', 'off', 'FontWeight', 'bold', 'FontName', 'Helvetica', 'NumColumns', 4);
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