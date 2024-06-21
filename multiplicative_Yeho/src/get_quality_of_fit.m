function out = get_quality_of_fit(P1_list, P1_exp)
out = 0.0;
for ii = 1:length(P1_exp)
    out = out + (P1_list(ii) - P1_exp(ii))^2 / P1_exp(ii);
end
end