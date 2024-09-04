function out = get_D_b(xi, be1, be2, be3)
dev_tau_a = zeros(3, 1);
lambda_e1 = sqrt(be1);
lambda_e2 = sqrt(be2);
lambda_e3 = sqrt(be3);
I1 = be1 + be2 + be3;

coe = (be1*be2*be3)^(-1.0/3.0) * 2.0 / 3.0;
dev_tau_a(1) = dPsi_dI1(xi, I1) * coe * (2.0 * be1 - be2 - be3);
dev_tau_a(2) = dPsi_dI1(xi, I1) * coe * (2.0 * be2 - be1 - be3);
dev_tau_a(3) = dPsi_dI1(xi, I1) * coe * (2.0 * be3 - be1 - be2);

T_ab = zeros(3,3);
T_ab(1,1) = 4.0 * be1 * be1 * dPsi_dI1(xi, I1) + 4.0 * lambda_e1 * lambda_e1 * get_Psi_Yeoh(xi, I1);
T_ab(1,2) = 4.0 * be1 * be2 * dPsi_dI1(xi, I1);
T_ab(1,3) = 4.0 * be1 * be3 * dPsi_dI1(xi, I1);
T_ab(2,1) = 4.0 * be2 * be1 * dPsi_dI1(xi, I1);
T_ab(2,2) = 4.0 * be2 * be2 * dPsi_dI1(xi, I1) + 4.0 * lambda_e2 * lambda_e2 * get_Psi_Yeoh(xi, I1);
T_ab(2,3) = 4.0 * be2 * be3 * dPsi_dI1(xi, I1);
T_ab(3,1) = 4.0 * be3 * be1 * dPsi_dI1(xi, I1);
T_ab(3,2) = 4.0 * be3 * be2 * dPsi_dI1(xi, I1);
T_ab(3,3) = 4.0 * be3 * be3 * dPsi_dI1(xi, I1) + 4.0 * lambda_e3 * lambda_e3 * get_Psi_Yeoh(xi, I1);
T_bar_ab = T_ab - get_trace(T_ab) / 3.0 .* eye(3);
out = zeros(3,1);
for ii = 1:3
    for jj = 1:3
        out(jj) = out(jj) + dev_tau_a(ii) * T_bar_ab(ii, jj);
    end
end
end