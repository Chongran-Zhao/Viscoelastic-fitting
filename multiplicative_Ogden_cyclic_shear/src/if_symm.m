function out = if_symm(A)
if abs(A(1,2) - A(2,1)) < 1.0e-10
    cdt1 = 1;
else
    cdt1 = 0;
end
if abs(A(1,3) - A(3,1)) < 1.0e-10
    cdt2 = 1;
else
    cdt2 = 0;
end
if abs(A(2,3) - A(3,2)) < 1.0e-10
    cdt3 = 1;
else
    cdt3 = 0;
end
if cdt1 == 1 && cdt2 == 1 && cdt3 == 1
    out = 1;
else
    out = 0;
end
end