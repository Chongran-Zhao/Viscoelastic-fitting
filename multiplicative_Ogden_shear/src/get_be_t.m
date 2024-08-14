% Ft is the deformation gradient array of total loading case with size of (3, 3, length of data)
% time is time list vector of total loading case
% The function is to calculate the be list of one specific relaxation process
% out is the elastic left-Cauchy Green strain tensor list during the total loading case
% refer to table 1 of Reese & Gocindjee 1998 IJSS

function out = get_be_t(time, mu_neq, alpha_neq, eta, Ft)
% out = zeros(size(Ft));
% for ii = 1:size(out, 3)
%     if (ii==1)
%         Cv_old = eye(3);
%         dt = time(ii);
%     else
%         dt = time(ii) - time(ii-1);
%         Cv_old = get_Cv_inv(Ft(:,:,ii-1), out(:,:,ii-1));
%     end
% 
%     be_trial = Ft(:,:,ii) * Cv_old * transpose(Ft(:,:,ii));
%     error = 1.0;
%     tol = 1e-5;
%     max_it_num = 1000;
%     counter = 0;
% 
%     [V_be_trial, D_be_trial] = eig(be_trial);
%     eig_val_be_trial = [D_be_trial(1,1); D_be_trial(2,2); D_be_trial(3,3)];
%     eig_val_be = eig_val_be_trial;
%     eig_vec_be = V_be_trial;
% 
%     eig_val_eps = 0.5 .* log(eig_val_be);
%     eig_val_eps_trial = 0.5 .* log(eig_val_be_trial);
% 
%     while (error > tol) && (counter < max_it_num)
%         residual = get_res(eig_val_be, eig_val_eps, eig_val_eps_trial, mu_neq, alpha_neq, dt, eta);
%         tangent = get_res_tangent(eig_val_be, mu_neq, alpha_neq, dt, eta);
% 
%         delta_epsilon = bicgstab(tangent, -residual);
%         delta_epsilon = tangent \ (-residual);
%         eig_val_eps = eig_val_eps + delta_epsilon;
%         error = norm(residual);
%         eig_val_be = exp(2.0 .* eig_val_eps);
%         counter = counter + 1;
%     end
%     out(:,:,ii) = tensor_product(eig_vec_be, eig_val_be);
% end
% out = zeros(size(Ft));
% out(:,:,1) = eye(3);
% for ii = 2:length(time)
%     dt = time(ii) - time(ii-1);
%     be_old = out(:,:,ii-1);
%     be_trail = Ft(:,:,ii) * get_Cv_inv(Ft(:,:,ii-1), out(:,:,ii-1)) * Ft(:,:,ii)';
%     tau_old = get_tau_iso_neq(mu_neq, alpha_neq, be_old);
%     out(:,:,ii) = be_trail - dt / eta .* (tau_old * be_trail);
% end
out = zeros(size(Ft));
out(:,:,1) = eye(3);
for ii = 2:length(time)
    dt = time(ii) - time(ii-1);
    be_trail = Ft(:,:,ii) * get_Cv_inv(Ft(:,:,ii-1), out(:,:,ii-1)) * Ft(:,:,ii)';
    out(:,:,ii) = inv(inv(be_trail) + dt / eta .* eye(3));
end
end
% EOF