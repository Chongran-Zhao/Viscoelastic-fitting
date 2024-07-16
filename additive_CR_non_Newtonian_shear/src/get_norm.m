function out = get_norm(A)
out = 0.0;
for ii = 1:3
    for jj = 1:3
        out = out + A(ii,jj)*A(ii,jj);
    end
end
out = sqrt(out);
end