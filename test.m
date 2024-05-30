clc; clear; close all
Treloar_UT_strain = importdata("./Treloar-UT/strain.txt");
Treloar_UT_stress = importdata("./Treloar-UT/stress.txt");

Treloar_ET_strain = importdata("./Treloar-ET/strain.txt");
Treloar_ET_stress = importdata("./Treloar-ET/stress.txt");

Treloar_PS_strain = importdata("./Treloar-PS/strain.txt");
Treloar_PS_stress = importdata("./Treloar-PS/stress.txt");

Ft = zeros(3,3,length(Treloar_UT_strain));
Ft(1,1,:) = Treloar_UT_strain(:);
Ft(2,2,:) = (Treloar_UT_strain(:)).^(-0.5);
Ft(3,3,:) = (Treloar_UT_strain(:)).^(-0.5);


time = linspace(1, length(Treloar_PS_strain), 5.0);
bet = zeros(length(time), 1);
% xi_eq = [-0.002159592828186, -2.459522226986577, 0.010982802848101, 4.018808768072496, 6.547826606246044, 0.112778494893808];
xi_eq = [1.0, 1.0, 1.0, 1.0, -1.0, -1.0];
xi_neq = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0];


objectiveFunction = @(paras) objective(paras, Ft, Treloar_UT_stress);
options = optimoptions('lsqnonlin', 'Algorithm', 'interior-point', 'MaxIterations', 5000);
% lb = [0.0, 0.0, 0.0, 0.0, -Inf, -Inf];
% ub = [Inf, Inf, Inf, Inf,  0.0,  0.0];
[paras, ~] = lsqnonlin( objectiveFunction, xi_eq, [], [], options);
P1_eq_list = get_P1_eq_list(paras, Ft);

plot(Treloar_UT_strain, Treloar_UT_stress, 'o', Color='r');
hold on
plot(Treloar_UT_strain, P1_eq_list, '-', Color='r');

function out = eq_dPsi_dlambda(paras, lambda)

out = paras(1) .* lambda.^( paras(2)-1.0 )...
    + paras(3) .* lambda.^( paras(4)-1.0 )...
    + paras(5) .* lambda.^( paras(6)-1.0 );
end

function out = neq_dPsi_dlambda(paras, lambda)

out = paras(1) .* lambda.^( paras(2)-1.0 )...
    + paras(3) .* lambda.^( paras(4)-1.0 )...
    + paras(5) .* lambda.^( paras(6)-1.0 );
end


function out = get_P_eq(paras, F)
out = F * get_S_eq(paras, F);
disp(out);
end

function out = get_S_eq(paras, F)
C_inv = inv(transpose(F)*F);
S_iso_eq = get_S_iso_eq(paras, F);
p = solve_p(paras, F);
out = -p .* C_inv + S_iso_eq;
end
function out = get_S_iso_eq(paras, F)
out = zeros(3,3);
C = transpose(F)*F;
[V, D] = eig(C);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
out = out + eq_dPsi_dlambda(paras, lambda1) ./ lambda1 .* kron(N1, N1') ;
out = out + eq_dPsi_dlambda(paras, lambda2) ./ lambda2 .* kron(N2, N2');
out = out + eq_dPsi_dlambda(paras, lambda3) ./ lambda3 .* kron(N3, N3');
end

function out = solve_p(paras, F)
S_iso_eq = get_S_iso_eq(paras, F);
C_inv = inv(transpose(F)*F);
p2 = S_iso_eq(2,2) / C_inv(2,2);
p3 = S_iso_eq(3,3) / C_inv(3,3);
if (p2 == p3)
    out = p2;
else
    error("ERROR: p2 != p3.")
end
% syms p
% P_eq = -p * C_inv + S_iso_eq;
% eqn1 = P_eq(2,2)==0;
% eqn2 = P_eq(3,3)==0;
% p1 = double(solve(eqn1, p));
% p2 = double(solve(eqn2, p));
% out = p1;
% if(p1 == p2)
%     out = p1;
% else
%     error("ERROR: can't sove pressure correctly.");
% end
end
function out = get_P1_eq(paras, F)
P_eq = get_P_eq(paras, F);
out = P_eq(1,1);
end

function out = get_P1_eq_list(paras, Ft)
out = zeros(size(Ft, 3), 1);
for ii = 1:length(out)
    out(ii) = get_P1_eq(paras, Ft(:,:,ii));
end
end

% function out = get_P1_neq(paras, Ft)
% end

function out = get_be(dt, be_old, paras, F, F_old)
C_old = transpose(F) * F;
[V_C, D_C] = eig(C_old);
[V_be_old, D_be_old] = eig(be_old);
sort_eig(V_C, D_C, V_be_old, D_be_old);
D_Cv_old = D_C / D_be_old;
Cv_old = tensor_product(V_C, D_Cv_old);
be_trial = F * Cv_old * transpose(F);
[V_be_trial, D_be_trial] = eig(be_trial);
epsilon_trial = zeros(3,3);
epsilon_trial = epsilon_trial + 

Cv_inv_trail = F * 
end
function out = objective(paras, Ft, P1_exp)
P1_eq = zeros(length(P1_exp));
for ii=1:length(P1_eq)
    P1_eq(ii) = get_P1_eq(paras, Ft(:,:,ii));
end
out = 1.0 / length(P1_exp) .* sum( (P1_eq - P1_exp).^2 );
end

function [V1, D1, V2, D2] = sort_eig(V1, D1, V2, D2)
[sorted_D1, idx1] = sort(diag(D1), 'descend');

V1 = V1(:, idx1);
D1 = diag(sorted_D1);

[sorted_D2, idx2] = sort(diag(D2), 'descend');

V2 = V2(:, idx2);
D2 = diag(sorted_D2);
end
function [V1, D1, V2, D2, V3, D3] = sort_eig(V1, D1, V2, D2, V3, D3)
[sorted_D1, idx1] = sort(diag(D1), 'descend');
[sorted_D2, idx2] = sort(diag(D2), 'descend');
[sorted_D3, idx3] = sort(diag(D3), 'descend');

V1 = V1(:, idx1);
D1 = diag(sorted_D1);

V2 = V2(:, idx2);
D2 = diag(sorted_D2);

V3 = V3(:, idx3);
D3 = diag(sorted_D3);
end


function out = tensor_product(V, D)
out = zeros(3,3);
out = out + V(1,1) .* korn(D(:,1), D(:,1)');
out = out + V(2,2) .* korn(D(:,2), D(:,2)');
out = out + V(3,3) .* korn(D(:,3), D(:,3)');
end

function out = get_tau_iso_neq(paras, be)
out = zeros(3, 3);
[V, D] = eig(be);
out = out + neq_dPsi_dlambda(paras, D(1,1)) ./ D(1,1) .* kron(V(:,1), V(:,1)');
out = out + neq_dPsi_dlambda(paras, D(2,2)) ./ D(2,2) .* kron(V(:,2), V(:,2)');
out = out + neq_dPsi_dlambda(paras, D(3,3)) ./ D(3,3) .* kron(V(:,3), V(:,3)');
end

function out = get_dev_tau_iso_neq(paras, be, C)
out = contraction(get_dev_P(C), get_tau_iso_neq(paras, be));
end

% generate the fourth-order viscosity tensor
function out = get_viscosity(eta)
out = zeros(3,3,3,3);
for ii=1:3
    for jj=1:3
        for kk=1:3
            for ll=1:3
                out(ii,jj,kk,ll) = out(ii,jj,kk,ll) + 0.5 / eta * (0.5*delta(ii,kk)*delta(jj,ll) + 0.5*delta(ii,ll)*delta(jj,kk) - 1.0/3.0 * delta(ii,jj)*delta(kk,ll));
            end
        end
    end
end
end

function out = get_dev_P(C)
out = get_4th_sym_iden() - 1.0/3.0 .* otimes(C, inv(C)); 
end

function out = get_4th_sym_iden()
out = zeros(3,3,3,3);
for ii=1:3
    for jj=1:3
        for kk=1:3
            for ll=1:3
                out(ii,jj,kk,ll) = 0.5 * delta(ii,kk)*delta(jj,ll) + 0.5 * delta(ii,ll)*delta(jj,kk);
            end
        end
    end
end
end
% tensor product of two second-order tensors
function out = otimes(A, B)
out = zeros(3,3,3,3);
for ii=1:3
    for jj=1:3
        for kk=1:3
            for ll=1:3
                out(ii,jj,kk,ll) = A(ii,jj) * B(kk,ll);
            end
        end
    end
end
end
% generate delta function
function out = delta(ii,jj)
if ii == jj
    out = 1.0;
else
    out = 0.0;
end
end
% fourth order viscosity constracting with second-order stress
function out = contraction(viscosity, stress)
out = zeros(3,3);
for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                out(ii,jj) = viscosity(ii,jj,kk,ll) * stress(kk,ll);
            end
        end
    end
end

end
function out = get_epsilon(be)
out = zeros(3, 3);
[V, D] = eig(be);
out = out + 0.5 * D(1,1) .* kron(V(:,1), V(:,1)');
out = out + 0.5 * D(2,2) .* kron(V(:,2), V(:,2)');
out = out + 0.5 * D(3,3) .* kron(V(:,3), V(:,3)');
end

function out = get_res(epsilon_prediction, dev_tau_iso_neq, epsilon_trial, dt, eta)
[V_eps_pre, D_eps_pre] = eig(epsilon_prediction);
[V_eps_tri, D_eps_tri] = eig(epsilon_trail);
[V_tau, D_tau] = eig(dev_tau_iso_neq);
sort_eig(V_eps_tri, D_eps_tri, V_tau, D_tau, V_eps_pre, D_eps_pre);
res1 = D_eps_pre(1,1) + dt * (0.5 / eta * D_tau(1,1)) - D_eps_tri(1,1);
res2 = D_eps_pre(2,2) + dt * (0.5 / eta * D_tau(2,2)) - D_eps_tri(2,2);
res3 = D_eps_pre(3,3) + dt * (0.5 / eta * D_tau(3,3)) - D_eps_tri(3,3);
out = [res1, res2, res3];
end

function out = get_tan_res(paras, D_be)
out = zeros(3,3);
coe1 = -2.0 / 9.0;
coe2 = 1.0 / 9.0;
for ii = 1:3
    for jj = 1:3
        if (jj ~= ii)
            for kk = 1:3
                if (kk ~= ii) && (kk ~= jj)
                    out(ii,jj) = out(ii,jj) + paras(1) * paras(2) * (coe1 * D_be(ii,ii)^(0.5*paras(2)) + coe1 * D_be(jj,jj)^(0.5*paras(2)) + coe2 * D_be(kk,kk)^(0.5*paras(2)));
                    out(ii,jj) = out(ii,jj) + paras(3) * paras(4) * (coe1 * D_be(ii,ii)^(0.5*paras(4)) + coe1 * D_be(jj,jj)^(0.5*paras(4)) + coe2 * D_be(kk,kk)^(0.5*paras(2)));
                    out(ii,jj) = out(ii,jj) + paras(5) * paras(6) * (coe1 * D_be(ii,ii)^(0.5*paras(6)) + coe1 * D_be(jj,jj)^(0.5*paras(6)) + coe2 * D_be(kk,kk)^(0.5*paras(2)));

                end
            end
        end
    end
end
end