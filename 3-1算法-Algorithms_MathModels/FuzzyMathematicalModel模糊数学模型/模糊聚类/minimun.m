function f1 = minimun(x)
% 模糊集A，B上的极小运算
    f1 = (x>=20 & x<50).*(x-20)/40 + (x>=50 & x<80).*(80-x)/40;  
end