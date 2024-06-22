function out = get_MSD(P1_exp, P1_list)
out = sum( (P1_exp-P1_list) .* (P1_exp-P1_list) ) / length(P1_exp);
end