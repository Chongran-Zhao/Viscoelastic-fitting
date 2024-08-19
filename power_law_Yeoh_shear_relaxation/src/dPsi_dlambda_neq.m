function out = dPsi_dlambda_neq(xi_neq, I1, lambda)
out = ( xi_neq(1) + 2.0*xi_neq(2)*(I1-3.0) + 3.0*xi_neq(3)*(I1-3)^2 ) * 2.0*lambda;
end
% EOF