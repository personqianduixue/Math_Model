%% 2、遗传模拟优化初始聚类中心
clc
clear all
close all
load X
m=size(X,2);% 样本特征维数
% 中心点范围[lb;ub]
lb=min(X);
ub=max(X);
%% 模糊C均值聚类参数
% 设置幂指数为3，最大迭代次数为20，目标函数的终止容限为1e-6
options=[3,20,1e-6];
% 类别数cn
cn=4;
%% 模拟退火算法参数
q =0.8;     % 冷却系数
T0=100;    % 初始温度
Tend=99.999;  % 终止温度
%% 定义遗传算法参数
sizepop=10;               %个体数目(Numbe of individuals)
MAXGEN=100;                %最大遗传代数(Maximum number of generations)
NVAR=m*cn;                %变量的维数
PRECI=10;                 %变量的二进制位数(Precision of variables)
pc=0.7;
pm=0.01;
trace=zeros(NVAR+1,MAXGEN);
%建立区域描述器(Build field descriptor)
FieldD=[rep([PRECI],[1,NVAR]);rep([lb;ub],[1,cn]);rep([1;0;1;1],[1,NVAR])];
Chrom=crtbp(sizepop, NVAR*PRECI); % 创建初始种群
V=bs2rv(Chrom, FieldD);
ObjV=ObjFun(X,cn,V,options); %计算初始种群个体的目标函数值
T=T0;
while T>Tend
    gen=0;                                               %代计数器
    while gen<MAXGEN                                     %迭代
        FitnV=ranking(ObjV);                          %分配适应度值(Assign fitness values)
        SelCh=select('sus', Chrom, FitnV);         %选择
        SelCh=recombin('xovsp', SelCh,pc);             %重组
        SelCh=mut(SelCh,pm);                                %变异
        V=bs2rv(SelCh, FieldD);
        newObjV=ObjFun(X,cn,V,options);  %计算子代目标函数值
        newChrom=SelCh;

        %是否替换旧个体
        for i=1:sizepop
            if ObjV(i)>newObjV(i)
                ObjV(i)=newObjV(i);
                Chrom(i,:)=newChrom(i,:);
            else
                p=rand;
                if p<=exp((newObjV(i)-ObjV(i))/T)
                    ObjV(i)=newObjV(i);
                    Chrom(i,:)=newChrom(i,:);
                end
            end
        end
        gen=gen+1;                                                 %代计数器增加
        [trace(end,gen),index]=min(ObjV);                          %遗传算法性能跟踪
        trace(1:NVAR,gen)=V(index,:);
        fprintf(1,'%d ',gen);
    end
    T=T*q;
    fprintf(1,'\n温度:%1.3f\n',T);
end
[newObjV,center,U]=ObjFun(X,cn,[trace(1:NVAR,end)]',options);  %计算最佳初始聚类中心的目标函数值
% 查看聚类结果
Jb=newObjV
U=U{1};
center=center{1};
figure
plot(X(:,1),X(:,2),'o')
hold on
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2, :) == maxU);
index3 = find(U(3, :) == maxU);
% 在前三类样本数据中分别画上不同记号 不加记号的就是第四类了
line(X(index1,1), X(index1, 2), 'linestyle', 'none','marker', '*', 'color', 'g');
line(X(index2,1), X(index2, 2), 'linestyle', 'none', 'marker', '*', 'color', 'r');
line(X(index3,1), X(index3, 2), 'linestyle', 'none', 'marker', '*', 'color', 'b');
% 画出聚类中心
plot(center(:,1),center(:,2),'v')
hold off
