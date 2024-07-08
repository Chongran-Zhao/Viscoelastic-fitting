% The function is used to get the inverse Cv based
% on the multiplicative decomposition
% refer to eqn. (10) of Reese & Govindjee 1998 IJSS
% F is a 3x3 dormation gradient
% be is a 3x3 left-Cauchy Green strain tensor
function out = get_Cv_inv(F, be)
out = inv(F) * be * inv(transpose(F));
end