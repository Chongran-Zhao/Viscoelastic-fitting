function out = get_Psi_Yeoh(xi, I1)
out = xi(1) * (I1 - 3.0) + xi(2) * (I1 - 3.0)^2.0 + xi(3) * (I1 - 3.0)^3.0;
end