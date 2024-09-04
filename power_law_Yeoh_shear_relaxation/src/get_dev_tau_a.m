function [tau1, tau2, tau3] = get_dev_tau_a(xi, be1, be2, be3)
detFm0d67 = (be1*be2*be3)^(-1.0/3.0);
be1 = be1 / detFm0d67;
be2 = be2 / detFm0d67;
be3 = be3 / detFm0d67;
I1 = be1 + be2 + be3;
coe = detFm0d67 * 2.0 / 3.0;
tau1 = dPsi_dI1(xi, I1) * coe * (2.0 * be1 - be2 - be3);
tau2 = dPsi_dI1(xi, I1) * coe * (2.0 * be2 - be1 - be3);
tau3 = dPsi_dI1(xi, I1) * coe * (2.0 * be3 - be1 - be2);
end