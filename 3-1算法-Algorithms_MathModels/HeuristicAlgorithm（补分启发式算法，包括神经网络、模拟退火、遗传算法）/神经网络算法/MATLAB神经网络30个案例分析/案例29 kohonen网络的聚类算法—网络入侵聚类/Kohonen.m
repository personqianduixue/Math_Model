web browser http://www.ilovematlab.cn/thread-64646-1-1.html
%% 清空环境变量
clc
clear

%% 数据处理
load data
input=datatrain(:,1:38);
%数据归一化
[inputn,inputps]=mapminmax(input);
%inputn=inputn';
[nn,mm]=size(inputn);

%% 网络构建
%输入层节点数
Inum=38; 

%Kohonen网络
M=6;
N=6; 
K=M*N;%Kohonen总节点数

%Kohonen层节点排序
k=1;
for i=1:M
    for j=1:N
        jdpx(k,:)=[i,j];
        k=k+1;
    end
end

%学习率
rate1max=0.2;   
rate1min=0.05;
%学习半径
r1max=1.5;         
r1min=0.8;

%权值初始化
w1=rand(Inum,K);    %第一层权值

%% 迭代求解
maxgen=10000;
for i=1:maxgen
    
    %自适应学习率和相应半径
    rate1=rate1max-i/maxgen*(rate1max-rate1min);
    r=r1max-i/maxgen*(r1max-r1min);
    
    %从数据中随机抽取
    k=unidrnd(4000);   
    x=inputn(k,:);

    %计算最优节点
    [mindist,index]=min(dist(x,w1));
    
    %计算周围节点
    d1=ceil(index/6);
    d2=mod(index,6);
    nodeindex=find(dist([d1 d2],jdpx')<r);
    
    %权值更新
    for j=1:K
        %满足增加权值
        if sum(nodeindex==j)
            w1(:,j)=w1(:,j)+rate1*(x'-w1(:,j));
        end
    end
end

%% 聚类结果
Index=[];
for i=1:4000
    [mindist,index]=min(dist(inputn(i,:),w1));
    Index=[Index,index];
end
web browser http://www.ilovematlab.cn/thread-64646-1-1.html