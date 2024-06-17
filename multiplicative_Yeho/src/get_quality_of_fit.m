function out = get_quality_of_fit(P1_list, P1_exp)
out = sum((P1_list - P1_exp).^2 ./ P1_exp);
end