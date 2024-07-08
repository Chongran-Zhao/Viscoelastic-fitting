function out = dPsi_dlambda_eq(xi_eq, I1, lambda1)
out = ( xi_eq(1) + 2.0*xi_eq(2)*(I1-3.0) + 3.0*xi_eq(3)*(I1-3)^2 ) * 2.0*lambda1;
end
% EOF