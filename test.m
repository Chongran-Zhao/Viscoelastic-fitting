clc; clear; close all
% xi_eq =  [1.0, 1.0, 1.0, 1.0, -1.0, -1.0];
xi_eq = [1.948379758734208   0.001038874981972   1.948466536801018   0.001038830914139  -0.001359939450977  -1.780081771148665
];
lambda1 = 1.239113200000000;
lambda2 = 0.898347799373234;
aa = eq_dPsi_dlambda(xi_eq, lambda1) / lambda1
bb = eq_dPsi_dlambda(xi_eq, lambda2) / lambda2
function out = eq_dPsi_dlambda(xi_eq, lambda)

out = xi_eq(1) * lambda^( xi_eq(2)-1.0 )...
    + xi_eq(3) * lambda^( xi_eq(4)-1.0 )...
    + xi_eq(5) * lambda^( xi_eq(6)-1.0 );
end











