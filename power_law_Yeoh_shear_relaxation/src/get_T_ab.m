function out = get_T_ab(xi, be1, be2, be3)
detFm0d67 = (be1*be2*be3)^(-1.0/3.0);
be1 = be1 / detFm0d67;
be2 = be2 / detFm0d67;
be3 = be3 / detFm0d67;

I1 = be1 + be2 + be3;

out = zeros(3,3);
out(1,1) = 4.0 * be1 * be1 * dPsi_dI1(xi, I1) + 4.0 * be1 * get_Psi_Yeoh(xi, I1);
out(1,2) = 4.0 * be1 * be2 * dPsi_dI1(xi, I1);
out(1,3) = 4.0 * be1 * be3 * dPsi_dI1(xi, I1);
out(2,1) = 4.0 * be2 * be1 * dPsi_dI1(xi, I1);
out(2,2) = 4.0 * be2 * be2 * dPsi_dI1(xi, I1) + 4.0 * be2 * get_Psi_Yeoh(xi, I1);
out(2,3) = 4.0 * be2 * be3 * dPsi_dI1(xi, I1);
out(3,1) = 4.0 * be3 * be1 * dPsi_dI1(xi, I1);
out(3,2) = 4.0 * be3 * be2 * dPsi_dI1(xi, I1);
out(3,3) = 4.0 * be3 * be3 * dPsi_dI1(xi, I1) + 4.0 * be3 * get_Psi_Yeoh(xi, I1);
end