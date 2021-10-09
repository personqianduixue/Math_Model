a=[2 -2 0; -2 4 0; 0 0 5];
b=eig(a);
if all(b>0)
    fprintf('二次型正定\n');
else
    fprintf('二次型非正定\n');
end
[c,d]=eig(a)   %c为正交变换的变换矩阵
