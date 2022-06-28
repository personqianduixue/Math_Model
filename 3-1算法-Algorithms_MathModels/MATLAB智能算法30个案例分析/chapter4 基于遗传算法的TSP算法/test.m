clear;
clc
for i=1:100
    i
    [L(i),P{i}]=GA_TSP;
end
[a,index]=min(L);
disp('最优解:')
disp(P{index})
disp(['总距离：',num2str(a)]);
A=P{index};
B=L(index);
save P A B

