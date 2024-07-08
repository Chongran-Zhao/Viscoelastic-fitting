clc;clear;close all
addpath("src/");
A = rand(3,3,3,3);
for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                A(ii,jj,kk,ll) = A(jj,ii,kk,ll);
            end
        end
    end
end

for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                A(ii,jj,kk,ll) = A(ii,jj,ll,kk);
            end
        end
    end
end

X = rand(3,3);
for ii = 1:3
    for jj = 1:3
        X(ii,jj) = X(jj,ii);
    end
end

B = contract(A,X);
X
XX = solve_AB(A,B)