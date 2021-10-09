clc
clear
A = [1 2 3;1/2  1 4;1/6 1/4 1];% 评判矩阵
%% 一致性检验和权向量计算

[n,n] = size(A);
[v,d] = eig(A);
r = d(1,1);
CI = (r-n)/(n-1);
RI=[0 0 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59 1.60 1.61 1.615 1.62 1.63];
CR=CI/RI(n);

if CR<0.10
    disp('此矩阵的一致性可以接受!');
    CR_Result= '通过';
else
    disp('此矩阵的一致性验证失败，请重新进行评分并在clear后重新运行程序!');
    CR_Result= '不通过';
    return;

end

%% 权向值计算

w  = v(:,1)/sum(v(:,1));
w = w';

%% 结果输出
disp('该判断矩阵权向量计算报告');
disp(['一致性指标：'str2num(CI)]);
disp(['一致性比例：'str2num(CR)]);
disp(['一致性检验结果：'CR_Result]);
disp(['特征值：'str2num(r)]);
disp(['权向量：'str2num(w)]);





