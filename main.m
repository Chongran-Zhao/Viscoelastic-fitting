clc; clear; close all

fid = fopen('data_1.txt', 'r');
data = textscan(fid, '%f %f %f', 'Delimiter', '\n');
fclose(fid);

stress = data{1}';
strain = data{2}';
time = data{3}';

Ft = zeros(3,3,length(strain));
Ft(1,1,:) = strain(:);
Ft(2,2,:) = (strain(:)).^(-0.5);
Ft(3,3,:) = (strain(:)).^(-0.5);

% xi_eq = [-0.002159592828186, -2.459522226986577, 0.010982802848101, 4.018808768072496, 6.547826606246044, 0.112778494893808];
% xi_eq =  [1.0, 1.0, 1.0, 1.0, -1.0, -1.0];
xi_neq = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];

be = get_be(time, xi_neq, Ft);
% disp(be);
% paras0 = [xi_eq, xi_neq];
% objectiveFunction = @(paras) objective(paras, Ft, stress, time);
% options = optimoptions('lsqnonlin', 'Algorithm', 'interior-point', 'MaxIterations', 5000);
% % lb = [0.0, 0.0, 0.0, 0.0, -Inf, -Inf];
% % ub = [Inf, Inf, Inf, Inf,  0.0,  0.0];
% [paras, ~] = lsqnonlin( objectiveFunction, paras0, [], [], options);
% P1_eq_list = get_P1_eq_list(paras, Ft);
% 
% plot(Treloar_UT_strain, Treloar_UT_stress, 'o', Color='r');
% hold on
% plot(Treloar_UT_strain, P1_eq_list, '-', Color='r');

function out = eq_dPsi_dlambda(xi_eq, lambda)

out = xi_eq(1) .* lambda.^( xi_eq(2)-1.0 )...
    + xi_eq(3) .* lambda.^( xi_eq(4)-1.0 )...
    + xi_eq(5) .* lambda.^( xi_eq(6)-1.0 );
end

function out = neq_dPsi_dlambda(xi_neq, lambda)

out = xi_neq(1) .* lambda.^( xi_neq(2)-1.0 )...
    + xi_neq(3) .* lambda.^( xi_neq(4)-1.0 )...
    + xi_neq(5) .* lambda.^( xi_neq(6)-1.0 );
end

function out = get_S_eq(xi_eq, F)
out = zeros(3,3);
C = transpose(F)*F;
[V, D] = eig(C);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
out = out + eq_dPsi_dlambda(xi_eq, lambda1) ./ lambda1 .* kron(N1, N1') ;
out = out + eq_dPsi_dlambda(xi_eq, lambda2) ./ lambda2 .* kron(N2, N2');
out = out + eq_dPsi_dlambda(xi_eq, lambda3) ./ lambda3 .* kron(N3, N3');
end

function out = get_S_neq(xi_neq, be)
out = zeros(3,3);
[V, D] = eig(be);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
lambda1 = sqrt(D(1,1));
lambda2 = sqrt(D(2,2));
lambda3 = sqrt(D(3,3));
out = out + neq_dPsi_dlambda(xi_neq, lambda1) ./ lambda1 .* kron(N1, N1') ;
out = out + neq_dPsi_dlambda(xi_neq, lambda2) ./ lambda2 .* kron(N2, N2');
out = out + neq_dPsi_dlambda(xi_neq, lambda3) ./ lambda3 .* kron(N3, N3');
end

function out = get_P_eq(xi_eq, F)
out = F * get_S_eq(xi_eq, F);
end

function out = get_P_neq(xi_neq, F, be)
out = F * get_S_neq(xi_neq, be);
end

function out = get_P_eq_list(xi_eq, Ft)
out = zeros(size(Ft));
for ii = 1:size(Ft, 3)
    out(:,:,ii) = get_P_eq(xi_eq, Ft(:,:,ii));
end
end

function out = get_P_neq_list(xi_neq, Ft, be)
out = zeros(size(Ft));
for ii=1:size(Ft, 3)
out(:,:,ii) = F * get_P_neq(xi_neq, Ft(:,:,ii), be(:,:,ii));
end
end

function out = get_Cv_inv(F, be)
out = inv(F) * be * inv(transpose(F));
end

function out = get_be(time, xi_neq, Ft)
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
    be = be_trial;
    eta = xi_neq(end);
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

function out = get_eig_val_tau_neq(xi_neq, eig_val_be)
out = zeros(3,1);
mu_neq = [xi_neq(1), xi_neq(3), xi_neq(5)];
alpha_neq = [xi_neq(2), xi_neq(4), xi_neq(6)];
coe1 = 2.0 / 3.0;
coe2 = -1.0 / 3.0;
for ii = 1:length(mu_neq)
    out(1) = out(1) + mu_neq(ii)*(coe1*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
    out(2) = out(2) + mu_neq(ii)*(coe1*eig_val_be(2)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(3)^(0.5*alpha_neq(ii)));
    out(3) = out(3) + mu_neq(ii)*(coe1*eig_val_be(3)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(1)^(0.5*alpha_neq(ii)) + coe2*eig_val_be(2)^(0.5*alpha_neq(ii)));
end
end

function out = get_epsilon(be)
out = zeros(3, 3);
[V, D] = eig(be);
out = out + 0.5 * D(1,1) .* kron(V(:,1), V(:,1)');
out = out + 0.5 * D(2,2) .* kron(V(:,2), V(:,2)');
out = out + 0.5 * D(3,3) .* kron(V(:,3), V(:,3)');
end

function out = get_res(eig_val_be, eig_val_eps, eig_val_eps_trial, xi_neq, dt, eta)
out = eig_val_eps + dt .* 0.5 ./ eta .* get_eig_val_tau_neq(xi_neq, eig_val_be) - eig_val_eps_trial;
end

function out = get_res_tangent(eig_val_be, xi_neq, dt, eta)
out = zeros(3,3);
coe1 = -2.0 / 9.0;
coe2 = 1.0 / 9.0;
coe3 = 4.0 / 9.0;
mu_neq = [xi_neq(1), xi_neq(3), xi_neq(5)];
alpha_neq = [xi_neq(2), xi_neq(4), xi_neq(6)];

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

function out = tensor_product(V, D)
out = zeros(3,3);
out = out + D(1) .* kron(V(:,1), V(:,1)');
out = out + D(2) .* kron(V(:,2), V(:,2)');
out = out + D(3) .* kron(V(:,3), V(:,3)');
end

function out = solve_p_list(xi_eq, xi_neq, Ft, be)
out = zeros(size(Ft, 3), 1);
for ii=1:length(out)
    C_inv = inv(transpose(Ft(:,:,ii)) * Ft(:,:,ii));
    S_eq = get_S_eq(xi_eq, Ft(:,:,ii));
    S_neq = get_S_neq(xi_neq, be(:,:,ii));
    out(ii) = (S_eq(2,2) + S_neq(2,2)) / C_inv(2,2);
end
end

function out = get_P1_list(xi_eq, xi_neq, Ft, be)
out = zeros(size(Ft, 3), 1);
p = solve_p_list(xi_eq, xi_neq, Ft, be);
for ii=1:length(out)
    P_eq = get_P_eq(xi_eq, Ft(:,:,ii));
    P_neq = get_P_neq(xi_neq, Ft(:,:,ii), be(:,:,ii));
    out(ii) = out(ii) + P_eq(1,1) + P_neq(1,1) - p(ii);
end
end

function out = objective(paras, Ft, time, P1_exp)
xi_eq = paras(1:6);
xi_neq = paras(1:end);
be = get_be(time, xi_neq, Ft);
P1_list = get_P1_list(xi_eq, xi_neq, Ft, be);
out = 1.0 / length(P1_exp) .* sum( (P1_list - P1_exp).^2 );
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