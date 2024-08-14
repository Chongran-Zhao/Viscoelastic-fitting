function out = add_4d(A, B)
out = A;
for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                out(ii,jj,kk,ll) = A(ii,jj,kk,ll) + B(ii,jj,kk,ll);
            end
        end
    end
end
end