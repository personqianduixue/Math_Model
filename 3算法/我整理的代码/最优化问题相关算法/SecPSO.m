function [xm,fv]=SecPSO(fitness,N,w,c1,c2,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%惯性权重：w
%学习因子1：c1
%学习因子2：c2
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;       %随机初始化位置
        xl(i,j)=randn;
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
    for i=1:N
        %二阶粒子群速度更新公式
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-2*x(i,:)+xl(i,:))+c2*rand*(pg-2*x(i,:)+xl(i,:));
        xl(i,:)=x(i,:);
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
