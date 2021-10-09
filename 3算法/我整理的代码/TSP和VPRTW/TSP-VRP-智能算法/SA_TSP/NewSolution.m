function S2=NewSolution(S1)
% 输入
% S1:当前解
% 输出
% S2：新解

Length=length(S1); %获得原解元素个数
S2=S1;

R=randperm(Length-2)+1; %产生2:CityNum+1的随机序列作为要交换位置的索引
S2(R(1:2))=S2(R(2:-1:1)); %换位