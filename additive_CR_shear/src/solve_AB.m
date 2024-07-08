% The code is aimed at solving AX=B,
% where A is the fourth order tensor, X and B are all second order tensor
function out = solve_AB(A, B)
map = [1, 6, 5, 6, 2, 4, 5, 4, 3];
AA = zeros(6,6);
BB = zeros(6,1);
for ii = 1:3
    for jj = 1:3
        BB(map(3*(ii-1)+jj)) = B(ii,jj);
        for kk = 1:3
            for ll = 1:3
                AA(map(3*(ii-1)+jj), map(3*(kk-1)+ll)) = A(ii,jj,kk,ll);
            end
        end
    end
end
XX = AA \ BB;
out = zeros(3,3);
for ii = 1:3
    for jj = 1:3
        if ii == jj
            out(ii,jj) = XX(map(3*(ii-1)+jj));
        else
            out(ii,jj) = 0.5 * XX(map(3*(ii-1)+jj));
        end
    end
end
end