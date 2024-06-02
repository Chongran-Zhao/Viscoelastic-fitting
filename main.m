clc; clear; close all

fid = fopen('data_0d6.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

stress = data{1}';
strain = data{2}';
time = data{3}';

Ft = zeros(3,3,length(strain));
Ft(1,1,:) = strain(:);
Ft(2,2,:) = (strain(:)).^(-0.5);
Ft(3,3,:) = (strain(:)).^(-0.5);

xi_eq_0 =  [2.0, 2.0];
xi_neq_0 = [1.0, 2.0];
eta_0 = 1;

paras0 = [xi_eq_0, xi_neq_0, eta_0];
objectiveFunction = @(paras) objective(paras, Ft, stress, time);
options = optimoptions('lsqnonlin', 'Algorithm', 'interior-point', 'MaxIterations', 5000);
% lb = [ 0.0, 0.0, 0.0, 0.0, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, 0.0];
% ub = [ Inf, Inf, Inf, Inf,  Inf,  Inf,  Inf,  Inf,  Inf,  Inf,  Inf,  Inf, Inf];
[paras, ~] = lsqnonlin( objectiveFunction, paras0, [], [], options);
xi_eq = paras(1:2)
xi_neq = paras(3:4)
eta = paras(end)
be = get_be(time, xi_neq, eta, Ft);
P1_list = get_P1_list(xi_eq, xi_neq, Ft, be);
P1_eq_list = get_P1_eq_list(xi_eq, Ft);

plot(strain, stress, 'o', Color='r');
hold on
plot(strain, P1_list, '-', Color='r');

% xi_eq is 2x1 array
% lambda is a scalar
function out = eq_dPsi_dlambda(xi_eq, lambda)
out = xi_eq(1) * lambda^( xi_eq(2)-1.0 );
end

% xi_neq is a 2x1 array
% lambda is a scalar
function out = neq_dPsi_dlambda(xi_neq, lambda)
out = xi_neq(1) .* lambda.^( xi_neq(2)-1.0 );
end

% xi_eq is a 6x1 array
% F is a 3x3 matrix
% out is a 3x3 matrix
function out = get_S_eq(xi_eq, F)
C = transpose(F)*F;
[V, D] = eig(C);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));

eig_val_S_eq = [eq_dPsi_dlambda(xi_eq, lambda1) / lambda1;...
                eq_dPsi_dlambda(xi_eq, lambda2) / lambda2;...
                eq_dPsi_dlambda(xi_eq, lambda3) / lambda3];
out = tensor_product(V, eig_val_S_eq);
end

% xi_neq is a 6x1 array
% F is a 3x3 matrix
% out is a 3x3 matrix
function out = get_S_neq(xi_neq, be, F)
out = inv(F) * get_tau_neq(xi_neq, be) * inv(transpose(F));
end

% xi_neq is a 6x1 array
% eig_val_be is a 1x3 vector
% out is a 1x3 vector
function out = get_eig_val_tau_neq(xi_neq, eig_val_be)
out = zeros(3,1);
mu_neq = [xi_neq(1)];
alpha_neq = [xi_neq(2)];
coe1 = 2.0 / 3.0;
coe2 = -1.0 / 3.0;
for ii = 1:length(mu_neq)
    out(1) = out(1) + mu_neq(ii)*(coe1*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
    out(2) = out(2) + mu_neq(ii)*(coe1*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
    out(3) = out(3) + mu_neq(ii)*(coe1*eig_val_be(3)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)));
end
end

function out = get_tau_neq(xi_neq, be)
[V, D] = eig(be);
eig_val_be = [D(1,1); D(2,2); D(3,3)];
eig_val_tau_neq = get_eig_val_tau_neq(xi_neq, eig_val_be);
out = tensor_product(V, eig_val_tau_neq);
end

% xi_eq is a 6x1 array
% F is a 3x3 matrix
% out is a 3x3 matrix
function out = get_P_eq(xi_eq, F)
out = F * get_S_eq(xi_eq, F);
% disp(out);
end

% xi_neq is a 6x1 array
% F is a 3x3 matrix
% be is a 3x3 matrix
% out is a 3x3 matrix
function out = get_P_neq(xi_neq, F, be)
out = F * get_S_neq(xi_neq, be, F);
end

% xi_eq is a 6x1 array
% Ft is size of (3, 3, length of data)
% out is the same size of Ft
function out = get_P_eq_list(xi_eq, Ft)
out = zeros(size(Ft));
for ii = 1:size(Ft, 3)
    out(:,:,ii) = get_P_eq(xi_eq, Ft(:,:,ii));
end
end

% xi_neq is a 6x1 array
% Ft is size of (3, 3, length of data)
% be_t is the same size of Ft
% out is the same size of Ft
function out = get_P_neq_list(xi_neq, Ft, be_t)
out = zeros(size(Ft));
for ii=1:size(Ft, 3)
out(:,:,ii) = F * get_P_neq(xi_neq, Ft(:,:,ii), be_t(:,:,ii));
end
end

% The function is used to extract the first pricipal
% value of equilibrium part of first PK stress
% xi_eq is a 6x1 array
% Ft is size of (3, 3, length of data)
% out is an array of length of data
function out = get_P1_eq_list(xi_eq, Ft)
out = zeros(size(Ft, 3), 1);
P_eq_list = get_P_eq_list(xi_eq, Ft);
for ii = 1:length(out)
    out(ii) = P_eq_list(1, 1, ii);
end
end

% The function is used to extract the first pricipal
% value of non-equilibrium part of first PK stress
% xi_neq is a 6x1 array
% Ft is size of (3, 3, length of data)
% be_t is same size of Ft
% out is an array of length of data
function out = get_P1_neq_list(xi_neq, Ft, be_t)
out = zeros(size(Ft, 3), 1);
P_neq_list = get_P_neq_list(xi_neq, Ft, be_t);
for ii = 1:length(out)
    out(ii) = P_neq_list(1, 1, ii);
end
end

% The function is used to get the inverse Cv based
% on the multiplicative decomposition
% refer to eqn. (10) of Reese & Govindjee 1998 IJSS
% F is a 3x3 matrix
% be is a 3x3 matrix
function out = get_Cv_inv(F, be)
out = inv(F) * be * inv(transpose(F));
end

% Ft is size of (3, 3, length of data)
% xi_neq is 6x1 array
% time is size of length of data
% out is same size of Ft
function out = get_be(time, xi_neq, eta, Ft)
out = zeros(size(Ft));
for ii = 1:size(out, 3)
    if (ii==1)
        Cv_old = eye(3);
        dt = time(ii);
    else
        dt = time(ii) - time(ii-1);
        Cv_old = get_Cv_inv(Ft(:,:,ii-1), out(:,:,ii-1));
    end
    
    be_trial = Ft(:,:,ii) * Cv_old * transpose(Ft(:,:,ii));
    error = 1.0;
    tol = 1e-5;
    max_it_num = 1000;
    counter = 0;

    [V_be_trial, D_be_trial] = eig(be_trial);
    eig_val_be_trial = [D_be_trial(1,1); D_be_trial(2,2); D_be_trial(3,3)];
    eig_val_be = eig_val_be_trial;
    eig_vec_be = V_be_trial;

    eig_val_eps = 0.5 .* log(eig_val_be);
    eig_val_eps_trial = 0.5 .* log(eig_val_be_trial);

    while (error > tol) && (counter < max_it_num)
        residual = get_res(eig_val_be, eig_val_eps, eig_val_eps_trial, xi_neq, dt, eta);
        tangent = get_res_tangent(eig_val_be, xi_neq, dt, eta);

        delta_epsilon = tangent \ (-residual);

        eig_val_eps = eig_val_eps + delta_epsilon;
        error = norm(residual);
        eig_val_be = exp(2.0 .* eig_val_eps);
        counter = counter + 1;
    end
    out(:,:,ii) = tensor_product(eig_vec_be, eig_val_be);
end
end


% all inputs are 1x3 eigenvalue vectors
% xi_neq is a 6x1 array
% dt is scalar
% eta is scalar
% out is a 1x3 vector
function out = get_res(eig_val_be, eig_val_eps, eig_val_eps_trial, xi_neq, dt, eta)
out = eig_val_eps + dt .* 0.5 ./ eta .* get_eig_val_tau_neq(xi_neq, eig_val_be) - eig_val_eps_trial;
end

% eig_val_be is a 1x3 vector
% xi_neq is a 6x1 array
% dt is a scalar
% eta is a scalar
% out is a 3x3 matrix
function out = get_res_tangent(eig_val_be, xi_neq, dt, eta)
out = zeros(3,3);
coe1 = -2.0 / 9.0;
coe2 = 1.0 / 9.0;
coe3 = 4.0 / 9.0;
mu_neq = [xi_neq(1)];
alpha_neq = [xi_neq(2)];

for ii = 1:length(mu_neq)
    out(1,2) = out(1,2) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
    out(1,3) = out(1,3) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))));
    out(2,3) = out(2,3) + mu_neq(ii) * alpha_neq(ii) * (coe1 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe1 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))));
    out(1,1) = out(1,1) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
    out(2,2) = out(2,2) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(2)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(3)^(0.5*alpha_neq(ii))));
    out(3,3) = out(3,3) + mu_neq(ii) * alpha_neq(ii) * (coe3 * (eig_val_be(3)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(1)^(0.5*alpha_neq(ii))) + coe2 * (eig_val_be(2)^(0.5*alpha_neq(ii))));
end
out = (0.5 .* dt ./ eta) .* out;
out(2,1) = out(1,2);
out(3,1) = out(1,3);
out(3,2) = out(2,3);
out(1,1) = out(1,1) + 1.0;
out(2,2) = out(2,2) + 1.0;
out(3,3) = out(3,3) + 1.0;
end

% D is a 1x3 vector containing three eigenvalues
% V is a 3x3 matrix containing three cooresponidng eigenvectors
function out = tensor_product(V, D)
out = zeros(3,3);
out = out + D(1) .* kron(V(:,1), V(:,1)');
out = out + D(2) .* kron(V(:,2), V(:,2)');
out = out + D(3) .* kron(V(:,3), V(:,3)');
end

% The function is used to solve the pressure p based
% on the incompressibility constrain of each time step
% both xi_eq and xi_neq are 6x1 arrays
% Ft is size of (3, 3, length of data)
% be is size of (3, 3, length of data)
% out is a array with length of data
function out = solve_p_list(xi_eq, xi_neq, Ft, be_t)
out = zeros(size(Ft, 3), 1);
for ii=1:length(out)
    F_inv_transpose = inv(transpose(Ft(:,:,ii)));
    P_eq = get_P_eq(xi_eq, Ft(:,:,ii));
    P_neq = get_P_neq(xi_neq, Ft(:,:,ii), be_t(:,:,ii));
    out(ii) = (P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2);
    if abs((P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2) - (P_eq(3,3) + P_neq(3,3)) / F_inv_transpose(3,3)) < 1e-6
        out(ii) = (P_eq(2,2) + P_neq(2,2)) / F_inv_transpose(2,2);
    else
        format long
        disp(xi_neq);
        disp(F_inv_transpose);
        disp((P_eq(3,3) + P_neq(3,3)) / F_inv_transpose(3,3));
        disp(get_tau_neq(xi_neq,be_t(:,:,ii)));
        error("ERROR: solve_p_list is wrong!");
    end
end
end

function out = get_P1_list(xi_eq, xi_neq, Ft, be)
out = zeros(size(Ft, 3), 1);
p = solve_p_list(xi_eq, xi_neq, Ft, be);
for ii=1:length(out)
    P_eq = get_P_eq(xi_eq, Ft(:,:,ii));
    P_neq = get_P_neq(xi_neq, Ft(:,:,ii), be(:,:,ii));
    F_inv_transpose = inv(transpose(Ft(:,:,ii)));
    out(ii) = out(ii) + P_eq(1,1) + P_neq(1,1) - p(ii)*F_inv_transpose(1,1);
end
end

function out = objective(paras, Ft, time, P1_exp)
xi_eq = paras(1:2);
xi_neq = paras(3:4);
eta = paras(end);
be = get_be(time, xi_neq, eta, Ft);
P1_list = get_P1_list(xi_eq, xi_neq, Ft, be);
% out = zeros(length(time), 1);
% for ii=1:length(out)
out = abs(P1_list - P1_exp)
% end
disp(out);

end

% generate the fourth-order viscosity tensor
% function out = get_viscosity(eta)
% out = zeros(3,3,3,3);
% for ii=1:3
%     for jj=1:3
%         for kk=1:3
%             for ll=1:3
%                 out(ii,jj,kk,ll) = out(ii,jj,kk,ll) + 0.5 / eta * (0.5*delta(ii,kk)*delta(jj,ll) + 0.5*delta(ii,ll)*delta(jj,kk) - 1.0/3.0 * delta(ii,jj)*delta(kk,ll));
%             end
%         end
%     end
% end
% end

% function out = get_dev_P(C)
% out = get_4th_sym_iden() - 1.0/3.0 .* otimes(C, inv(C)); 
% end

% function out = get_4th_sym_iden()
% out = zeros(3,3,3,3);
% for ii=1:3
%     for jj=1:3
%         for kk=1:3
%             for ll=1:3
%                 out(ii,jj,kk,ll) = 0.5 * delta(ii,kk)*delta(jj,ll) + 0.5 * delta(ii,ll)*delta(jj,kk);
%             end
%         end
%     end
% end
% end

% tensor product of two second-order tensors
% function out = otimes(A, B)
% out = zeros(3,3,3,3);
% for ii=1:3
%     for jj=1:3
%         for kk=1:3
%             for ll=1:3
%                 out(ii,jj,kk,ll) = A(ii,jj) * B(kk,ll);
%             end
%         end
%     end
% end
% end

% generate delta function
% function out = delta(ii,jj)
% if ii == jj
%     out = 1.0;
% else
%     out = 0.0;
% end
% end

% fourth order viscosity constracting with second-order stress
% function out = contraction(viscosity, stress)
% out = zeros(3,3);
% for ii = 1:3
%     for jj = 1:3
%         for kk = 1:3
%             for ll = 1:3
%                 out(ii,jj) = viscosity(ii,jj,kk,ll) * stress(kk,ll);
%             end
%         end
%     end
% end
% end