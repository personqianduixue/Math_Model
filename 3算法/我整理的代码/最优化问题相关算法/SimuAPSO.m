function [xm,fv]=SimuAPSO(fitness,N,c1,c2,lamda,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%学习因子1：c1
%学习因子2：c2
%退火常数：lamda
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;               %随机初始化位置
        v(i,j)=randn;               %随机初始化速度
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);                          %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
T=fitness(pg)/log(5);               %初始温度
for t=1:M
    groupFit=fitness(pg);
    for i=1:N
        Tfit(i)=exp(-(p(i)-groupFit)/T);
    end
    SumTfit=sum(Tfit);
    Tfit=Tfit/SumTfit;
    pBet=rand();
    for i=1:N                       %用轮盘赌策略确定全局最优的某个替代值
        ComFit(i)=sum(Tfit(1:i));
        if pBet<=ComFit(i)
            pg_plus=x(i,:);
            break;
        end
    end
    C=c1+c2;
    ksi=2/abs(2-C-sqrt(C^2-4*C));   %速度压缩因子
    for i=1:N
        v(i,:)=ksi*(v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg_plus-x(i,:)));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    T=T*lamda;                      %退温操作
end
xm=pg';
fv=fitness(pg);