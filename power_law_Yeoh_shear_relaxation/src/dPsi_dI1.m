function out = dPsi_dI1(xi, I1)
out = xi(1) + 2.0 * xi(2) * (I1 - 3.0) + 3 * xi(3) * (I1 - 3.0)^2;
end