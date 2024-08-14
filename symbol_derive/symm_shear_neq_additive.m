clc;
clear;
close all
syms k dt eta mu m n
F = [1, k, 0; 0, 1, 0; 0, 0, 1];
E_scale = @(lambda) 1/(m+n) * (lambda^m - lambda^(-n));
d = @(lambda) 1/(m+n) * (m*lambda^(m-1) + n*lambda^(-n-1)) / lambda;
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

% find E
E = E_scale(lambda1) .* kron(transpose(N1), N1);
E = E + E_scale(lambda2) .* kron(transpose(N2), N2);
E = E + E_scale(lambda3) .* kron(transpose(N3), N3);

% find Ev
% Ev = exp(-mu*dt/eta) .* Ev_old + mu*dt/eta .* E;

% find projection Q
d1 = d(lambda1);
d2 = d(lambda2);
d3 = d(lambda3);

theta_12 = 2 * (E_scale(lambda1) - E_scale(lambda2)) / (lambda1^2 - lambda2^2);
theta_21 = theta_12;
theta_13 = 2 * (E_scale(lambda1) - E_scale(lambda3)) / (lambda1^2 - lambda3^2);
theta_31 = theta_13;
theta_23 = 2 * (E_scale(lambda2) - E_scale(lambda3)) / (lambda2^2 - lambda3^2);
theta_32 = theta_23;


M_11 = sym('M_11', [3,3,3,3]);
M_22 = sym('M_22', [3,3,3,3]);
M_33 = sym('M_33', [3,3,3,3]);

M_12 = sym('M_12', [3,3,3,3]);
M_21 = sym('M_21', [3,3,3,3]);
M_13 = sym('M_13', [3,3,3,3]);
M_31 = sym('M_31', [3,3,3,3]);
M_23 = sym('M_23', [3,3,3,3]);
M_32 = sym('M_32', [3,3,3,3]);

out = zeros(3,3,3,3);
for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                M_11(ii,jj,kk,ll) = N1(ii) * N1(jj) * N1(kk) * N1(ll);
                M_22(ii,jj,kk,ll) = N2(ii) * N2(jj) * N2(kk) * N2(ll);
                M_33(ii,jj,kk,ll) = N3(ii) * N3(jj) * N3(kk) * N3(ll);

                M_12(ii,jj,kk,ll) = 0.5 * N1(ii) * N2(jj) * N1(kk) * N2(ll);
                M_12(ii,jj,kk,ll) = 0.5 * N1(ii) * N2(jj) * N2(kk) * N1(ll);

                M_21(ii,jj,kk,ll) = 0.5 * N2(ii) * N1(jj) * N2(kk) * N1(ll);
                M_21(ii,jj,kk,ll) = 0.5 * N2(ii) * N1(jj) * N1(kk) * N2(ll);

                M_13(ii,jj,kk,ll) = 0.5 * N1(ii) * N3(jj) * N1(kk) * N3(ll);
                M_13(ii,jj,kk,ll) = 0.5 * N1(ii) * N3(jj) * N3(kk) * N1(ll);

                M_31(ii,jj,kk,ll) = 0.5 * N3(ii) * N1(jj) * N3(kk) * N1(ll);
                M_31(ii,jj,kk,ll) = 0.5 * N3(ii) * N1(jj) * N1(kk) * N3(ll);
                
                M_23(ii,jj,kk,ll) = 0.5 * N2(ii) * N3(jj) * N2(kk) * N3(ll);
                M_23(ii,jj,kk,ll) = 0.5 * N2(ii) * N3(jj) * N3(kk) * N2(ll);

                M_32(ii,jj,kk,ll) = 0.5 * N3(ii) * N2(jj) * N3(kk) * N2(ll);
                M_32(ii,jj,kk,ll) = 0.5 * N3(ii) * N2(jj) * N2(kk) * N3(ll);
            end
        end
    end
end

Q = d1 .* M_11;
Q = Q + d2 .* M_22;
Q = Q + d3 .* M_33;
Q = Q + theta_12 .* M_12;
Q = Q + theta_21 .* M_21;
Q = Q + theta_13 .* M_13;
Q = Q + theta_31 .* M_31;
Q = Q + theta_23 .* M_23;
Q = Q + theta_32 .* M_32;


data = readmatrix('../exp_data_symmetric_shear_raw/400.xlsx');
time = data(:,1);
% P_exp = data(:,3);
gamma = data(:,4);
P_12 = zeros(length(time), 1);
m_value = -1;
n_value = -1;
mu_value = 1.0;
eta_value = 1000.0;
Ev_old = zeros(3,3);
E_old = zeros(3,3);
for ii = 2:length(time)
dt_value = time(ii) - time(ii-1);
E_new = double(subs(E, {k,m,n}, {gamma(ii), m_value, n_value}));
Ev_new = exp(-mu_value*dt_value/eta_value) .* Ev_old + mu_value*dt_value/eta_value .* E_old;
Q_value = subs(Q, {m, n, k}, {m_value, n_value, gamma(ii)});
S_new = 2 * mu_value .* contract(E_new - Ev_new, Q_value);
F_new = subs(F, {k}, {gamma(ii)});
P = F_new * S_new;
P_12(ii) = P(1,2);
Ev_old = Ev_new;
E_old = E_new;
end

ax = axes('Position', [0.1 0.4 0.8 0.5], 'Box', 'on');
plot(ax, gamma(1:102), P_12(1:102), 'Color', '#ffa600', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 5, 'LineStyle', '-', LineWidth=2.0);
hold on
plot(ax, gamma(103:221), P_12(103:221), 'Color', 'r', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 5, 'LineStyle', '-', LineWidth=2.0);
hold on
plot(ax, gamma(222:366), P_12(222:366), 'Color', 'b', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 5, 'LineStyle', '-', LineWidth=2.0);
hold on
plot(ax, gamma(367:end), P_12(367:end), 'Color', 'g', 'Marker', 'o', 'MarkerFaceColor', '#ffa600', 'MarkerSize', 5, 'LineStyle', '-', LineWidth=2.0);

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
