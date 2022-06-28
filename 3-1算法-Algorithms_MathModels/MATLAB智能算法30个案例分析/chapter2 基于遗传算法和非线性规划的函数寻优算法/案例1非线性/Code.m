function ret=Code(lenchrom,bound)
%本函数将变量编码成染色体，用于随机初始化一个种群
% lenchrom   input : 染色体长度
% bound      input : 变量的取值范围
% ret        output: 染色体的编码值

flag=0;
while flag==0
    pick=rand(1,length(lenchrom));
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %线性插值
    flag=test(lenchrom,bound,ret);             %检验染色体的可行性
end