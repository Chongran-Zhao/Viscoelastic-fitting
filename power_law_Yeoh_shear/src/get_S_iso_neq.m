function out = get_S_iso_neq(xi_neq, be, F)
out = inv(F) * get_tau_iso_neq(xi_neq, be) * inv(transpose(F));
end
% EOF