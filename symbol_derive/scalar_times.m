function out = scalar_times(b, A)
out = A;
for ii = 1:3
    for jj = 1:3
        for kk = 1:3
            for ll = 1:3
                out(ii,jj,kk,ll) = b * A(ii,jj,kk,ll);
            end
        end
    end
end
end