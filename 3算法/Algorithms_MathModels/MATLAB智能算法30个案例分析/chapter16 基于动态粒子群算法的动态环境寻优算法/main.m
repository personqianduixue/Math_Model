%% 动态粒子群算法

%% 清空环境
clear
clc

%% 设置双峰参数
% 设置con1参数
X1 = 25;
Y1 = 25;
H1 =410;

%设置con2参数
H2=zeros(1,1200);
i=1:200;
H2(i)=450-fix(i/5);
i=201:700;
H2(i)=410;
i=701:1000;
H2(i)=350 + fix((i-500)/10)*3;
i=1001:1200;
H2(i) = 500;

X2=zeros(1,1200);
i=1:1200;
Y2(i)=-25;
i=1:500;
X2(i)=-25 + (i-1)*25/500;
i=501:1000;
X2(i)=0;
i=1001:1200;
X2(i)=(i-1000)*25/200;

%% 初始化粒子和敏感粒子
% 种群规模
n = 20;
% 粒子和敏感粒子
pop = unidrnd(501,[n,2]);
popTest = unidrnd(501,[5*n,2]);
% 数字高度
h = DF1function(X1,Y1,H1,X2(1),Y2(1),H2(1));
V = unidrnd(100,[n,2])-50;
Vmax=25;Vmin=-25;

%% 粒子和敏感粒子适应度值
fitness=zeros(1,n);
fitnessTest=zeros(1,n);
for i=1:n
    fitness(i)=h(pop(i,1),pop(i,2));
    fitnessTest(i)=h(popTest(i,1),popTest(i,2));
end
oFitness=sum(fitnessTest); %敏感粒子
[value,index]=max(fitness);
popgbest=pop;
popzbest=pop(index,:);
fitnessgbest=fitness;
fitnesszbest=fitness(index);

%% 算法参数
vmax = 10;
vmin = -10;
popMax=501;
popMin=1;
m = 2;
nFitness = oFitness;
Tmax=100; %每次迭代次数
fitnessRecord=zeros(1,1200);
%% 循环寻找最优点
for k = 1:1200
    k

    % 新数字地图
    h = DF1function(X1,Y1,H1,X2(k),Y2(k),H2(k));
    
    % 敏感粒子变化
    for i=1:5*n
        fitnessTest(i)=h(popTest(i,1),popTest(i,2));
    end
    oFitness=sum(fitnessTest);
    
    % 变化超过阈值，重新初始化
    if abs(oFitness - nFitness)>1
        index=randperm(20);
        pop(index(1:10),:)=unidrnd(501,[10,2]);
        V(index(1:10),:)=unidrnd(100,[10,2])-50;
    end
    
    % 粒子搜索
    for i=1:Tmax
    
        for j=1:n
            % 速度更新
            V(j,:)=V(j,:)+floor(rand*(popgbest(j,:)-pop(j,:)))+floor(rand*(popzbest - pop(j,:)));
            index1=find(V(j,:)>Vmax);
            V(j,index1)=Vmax;
            index2=find(V(j,:)<Vmin);
            V(j,index2)=Vmin;
            
            % 个体更新
            pop(j,:)=pop(j,:)+V(j,:);
            index1=find(pop(j,:)>popMax);
            pop(j,index1)=popMax;
            index2=find(pop(j,:)<popMin);
            pop(j,index2)=popMin;
            
            % 新适应度值
            fitness(j)=h(pop(j,1),pop(j,2));
            
            % 个体极值更新
            if fitness(j) > fitnessgbest(j)
                popgbest(j,:) = pop(j,:);
                fitnessgbest(j) = fitness(j);
            end   
            
            % 群体极值更新
            if fitness(j) > fitnesszbest
                popzbest= pop(j,:);
                fitnesszbest = fitness(j);
            end
            
        end
    end
    
    fitnessRecord(k)=fitnesszbest;
    fitnesszbest=0;
    fitnessgbest=zeros(1,20);
end

figure
plot(fitnessRecord(1:1200),'*-')
title('动态最优值')