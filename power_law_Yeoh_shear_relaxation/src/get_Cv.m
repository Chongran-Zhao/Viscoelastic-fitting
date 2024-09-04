function out = get_Cv(F, be)
out = transpose(F) * inv(be) * F;
end