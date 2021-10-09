function [fitness,X]=FitnessFunction(binary,lenchrom)
%% 适应度函数
% 输入  binary：二进制编码
%     lenchrom：各变量的二进制位数
% 输出 fitness：适应度
%            X：十进制数（待优化参数）
sizepop=size(binary,1);
fitness=zeros(1,sizepop);
num=size(lenchrom,2);
X=zeros(sizepop,num);
for i=1:sizepop
    [fitness(i),X(i,:)]=Objfunction(binary(i,:),lenchrom);         % 使用目标函数计算适应度
end
