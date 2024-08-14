function [c, ceq] = constrain(paras)
c = [];
c = [c, -paras(2)*paras(3)];
c = [c, -paras(5)*paras(6)];
c = [c, -paras(9)*paras(10)];
c = [c, -paras(13)*paras(14)];
c_eq = [];
end