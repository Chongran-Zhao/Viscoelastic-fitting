function out = get_proj_P( F )
C = F' * F;
out = get_sym_idn_4d();
out = out - (1.0/3.0) .* cross_otimes_2d_to_4d(inv(C), C);
end