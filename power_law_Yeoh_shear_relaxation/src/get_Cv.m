function out = get_Cv(F, be)
be = be ./ det(be)^(-1.0/3.0);
out = F' * inv(be) * F;
end