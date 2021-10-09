function [xm,fv]=BreedPSO(fitness,N,c1,c2,w,Pc,Sp,M,D)
%待优化的目标函数：fitness
%粒子数目：N
%学习因子1：c1
%学习因子2：c2
%惯性权重：w
%杂交概率：Pc
%杂交池大小比例：Sp
%最大迭代次数：M
%问题的维数：D
%目标函数取最小值时的自变量值：xm
%目标函数的最小值：fv

format long;
for i=1:N
    for j=1:D
        x(i,j)=randn;           %初始化随机位置
        v(i,j)=randn;           %初始化随机速度
    end
end
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);                      %pg为全局最优
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
for t=1:M
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
        r1=rand();
        if r1<Pc                        %杂交概率
            numPool=round(Sp*N);            %杂交池的大小
            PoolX=x(1:numPool,:);           %杂交池中的粒子的位置
            PoolVX=v(1:numPool,:);          %杂交池中的粒子的速度
            for i=1:numPool
                seed1=floor(rand()*(numPool-1))+1;
                seed2=floor(rand()*(numPool-1))+1;
                pb=rand();
                %子代的位置计算
                childx1(i,:)=pb*PoolX(seed1,:)+(1-pb)*PoolX(seed2,:);
                %子代的速度计算
                childv1(i,:)=(PoolVX(seed1,:)+PoolVX(seed2,:))*norm(PoolVX(seed1,:))/norm(PoolVX(seed1,:)+PoolVX(seed2,:));
            end
            x(1:numPool,:)=childx1;         %子代的位置替换父代位置
            v(1:numPool,:)=childv1;         %自代的速度替换父代速度
        end
    end
end
xm=pg';
fv=fitness(pg);