% The function is used to calculate contraction between
% 3x3x3x3 fourth-order tensor and 3x3 second-order tensor
function out = contract(A, B)
out = zeros(3,3);
if length(size(A)) == 4
    for ii = 1:3
        for jj = 1:3
            for kk = 1:3
                for ll = 1:3
                    out(ii,jj) = out(ii,jj) + A(ii,jj,kk,ll) * B(kk,ll);
                end
            end
        end
    end
elseif length(size(B)) == 4
    for ii = 1:3
        for jj = 1:3
            for kk = 1:3
                for ll = 1:3
                    out(ii,jj) = out(ii,jj) + A(ii,jj) * B(ii,jj,kk,ll);
                end
            end
        end
    end
else
    error("ERROR: wrong size of input!");
end
end