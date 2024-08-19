function [xi_eq, xi_neq, C1, C2, tau_hat, power_m] = paras_to_array(paras)
xi_eq = paras(1:3);
xi_neq = [];
C1 = [];
C2 = [];
tau_hat = [];
power_m = [];
for ii = 1:2
    xi_neq = [xi_neq; paras(3+7*(ii-1)+1), paras(3+7*(ii-1)+2), paras(3+7*(ii-1)+3)];
    C1 = [C1, paras(3+7*(ii-1)+4)];
    C2 = [C2, paras(3+7*(ii-1)+5)];
    tau_hat = [tau_hat, paras(3+7*(ii-1)+6)];
    power_m = [power_m, paras(3+7*(ii-1)+7)];
end
end