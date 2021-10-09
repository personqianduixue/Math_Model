function [xm,fv]=AsyLnCPSO(fitness,N,c1max,c1min,c2max,c2min,w,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%学习因子1的最大值：c1max
%学习因子1的最小值：c1min
%学习因子2的最大值：c2max
%学习因子2的最小值：c2min
%惯性权重：w
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量的值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;       %随机初始化位置
        v(i,j)=randn;       %随机初始化速度
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);                  %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for t=1:M
    c1=c1max-(c1max-c1min)*t/M;     %线性变化的学习因子1
    c2=c2max-(c2max-c2min)*y/M;     %线性变化的学习因子2
    for i=1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
end
xm=pg';
fv=fitness(pg);