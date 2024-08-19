function out = get_lambda_chian(C)
[V, D] = eig(C);
out = sqrt((D(1,1) + D(2,2) + D(3,3)) / 3.0);
end