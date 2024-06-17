% mu_neq and alpha_neq are parameter arrays with same length
% be is the elastic left-Cauchy Green strain tensor at one specific time
% The function utilizes the eigenvalues and eigenvectors of be
% to output one 3x3 isochoric Kirchhoff stress tensor

function out = get_tau_iso_neq(xi_neq, be)
[V, D] = eig(be);
eig_val_be = [D(1,1); D(2,2); D(3,3)];
eig_val_tau_iso_neq = get_eig_val_tau_iso_neq(xi_neq, eig_val_be);
out = tensor_product(V, eig_val_tau_iso_neq);
end
% EOF