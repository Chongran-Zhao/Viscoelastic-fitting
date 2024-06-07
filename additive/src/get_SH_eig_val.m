% lambda is one 1x3 vector containing three principal stretch
% out is one 1x3 vector containing three eigenvalues of SH strain
function out = get_SH_eig_val(m, lambda)
out = [get_SH_scale(m,lambda(1)); get_SH_scale(m,lambda(2)); get_SH_scale(m,lambda(3))];
end