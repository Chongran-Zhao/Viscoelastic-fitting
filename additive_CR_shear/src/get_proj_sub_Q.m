function out = get_proj_sub_Q(m, C)
out = zeros(3,3,3,3);

[V, D] = eig(C);
N1 = V(:,1);
N2 = V(:,2);
N3 = V(:,3);
C1 = D(1,1);
C2 = D(2,2);
C3 = D(3,3);
d1 = C1^(0.5*m-1.0);
d2 = C2^(0.5*m-1.0);
d3 = C3^(0.5*m-1.0);

out = out + d1 .* cross_otimes_1d_to_4d(N1, N1, N1, N1);
out = out + d2 .* cross_otimes_1d_to_4d(N2, N2, N2, N2);
out = out + d3 .* cross_otimes_1d_to_4d(N3, N3, N3, N3);
if m == 0.0
    E1 = 0.5 * log(C1);
    E2 = 0.5 * log(C2);
    E3 = 0.5 * log(C3);
else
    E1 = (C1^(0.5*m) - 1.0) / m;
    E2 = (C2^(0.5*m) - 1.0) / m;
    E3 = (C3^(0.5*m) - 1.0) / m;
end

if C1 == C2 && C2 == C3
    theta_12 = 0.5 * d1;
    theta_13 = theta_12;
    theta_23 = theta_12;
elseif C2 == C3
    theta_12 = (E1 - E2) / (C1 - C2);
    theta_13 = (E1 - E3) / (C1 - C3);
    theta_23 = 0.5 * d2;
elseif C1 == C3
    theta_12 = (E1 - E2) / (C1 - C2);
    theta_23 = (E2 - E3) / (C2 - C3);
    theta_13 = 0.5 * d1;
else
    theta_12 = (E1 - E2) / (C1 - C2);
    theta_23 = (E2 - E3) / (C2 - C3);
    theta_13 = (E1 - E3) / (C1 - C3);
end
out = out + theta_12 .* (cross_otimes_1d_to_4d(N1, N2, N1, N2) + cross_otimes_1d_to_4d(N1, N2, N2, N1));
out = out + theta_12 .* (cross_otimes_1d_to_4d(N2, N1, N2, N1) + cross_otimes_1d_to_4d(N2, N1, N1, N2));
out = out + theta_23 .* (cross_otimes_1d_to_4d(N2, N3, N2, N3) + cross_otimes_1d_to_4d(N2, N3, N3, N2));
out = out + theta_23 .* (cross_otimes_1d_to_4d(N3, N2, N3, N2) + cross_otimes_1d_to_4d(N3, N2, N2, N3));
out = out + theta_13 .* (cross_otimes_1d_to_4d(N1, N3, N1, N3) + cross_otimes_1d_to_4d(N1, N3, N3, N1));
out = out + theta_13 .* (cross_otimes_1d_to_4d(N3, N1, N3, N1) + cross_otimes_1d_to_4d(N3, N1, N1, N3));
end