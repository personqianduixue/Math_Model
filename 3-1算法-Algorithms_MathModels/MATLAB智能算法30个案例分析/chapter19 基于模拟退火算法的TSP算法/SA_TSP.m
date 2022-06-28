clc;
clear;
close all;
%%
tic
T0=1000;   % 初始温度
Tend=1e-3;  % 终止温度
L=500;    % 各温度下的迭代次数（链长）
q=0.9;    %降温速率

%% 加载数据
load CityPosition1;
%%
D=Distanse(X);  %计算距离矩阵
N=size(D,1);    %城市的个数
%% 初始解
S1=randperm(N);  %随机产生一个初始路线

%% 画出随机解的路径图
DrawPath(S1,X)
pause(0.0001)
%% 输出随机解的路径和总距离
disp('初始种群中的一个随机值:')
OutputPath(S1);
Rlength=PathLength(D,S1);
disp(['总距离：',num2str(Rlength)]);

%% 计算迭代的次数Time
Time=ceil(double(solve(['1000*(0.9)^x=',num2str(Tend)])));
count=0;        %迭代计数
Obj=zeros(Time,1);         %目标值矩阵初始化
track=zeros(Time,N);       %每代的最优路线矩阵初始化
%% 迭代
while T0>Tend
    count=count+1;     %更新迭代次数
    temp=zeros(L,N+1);
    for k=1:L
        %% 产生新解
        S2=NewAnswer(S1);
        %% Metropolis法则判断是否接受新解
        [S1,R]=Metropolis(S1,S2,D,T0);  %Metropolis 抽样算法
        temp(k,:)=[S1 R];          %记录下一路线的及其路程
    end
    %% 记录每次迭代过程的最优路线
    [d0,index]=min(temp(:,end)); %找出当前温度下最优路线
    if count==1 || d0<Obj(count-1)
        Obj(count)=d0;           %如果当前温度下最优路程小于上一路程则记录当前路程
    else
        Obj(count)=Obj(count-1);%如果当前温度下最优路程大于上一路程则记录上一路程
    end
    track(count,:)=temp(index,1:end-1);  %记录当前温度的最优路线
    T0=q*T0;     %降温
    fprintf(1,'%d\n',count)  %输出当前迭代次数
end
%% 优化过程迭代图
figure
plot(1:count,Obj)
xlabel('迭代次数')
ylabel('距离')
title('优化过程')

%% 最优解的路径图
DrawPath(track(end,:),X)

%% 输出最优解的路线和总距离
disp('最优解:')
S=track(end,:);
p=OutputPath(S);
disp(['总距离：',num2str(PathLength(D,S))]);
disp('-------------------------------------------------------------')
toc