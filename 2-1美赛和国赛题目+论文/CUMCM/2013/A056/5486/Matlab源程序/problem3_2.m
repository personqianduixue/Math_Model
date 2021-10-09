% 问题3 解法二
clc;
close all;
clear;

load('problem3.mat');
%% 计算排队长度
M =2;L = 0.120;N0 = 12;
kj = 160;km = 59;
shangyous(1) = shangyou(1);
xiayous(1) = xiayou(1);
%计算累计数
for i = 2:size(shangyou,1)
   shangyous(i) = sum(shangyou(1:i,1)); 
   xiayous(i) = sum(xiayou(1:i,1));
end


for i = 2:size(shangyou,1)
   D(i) = 1000*(N0+shangyous(i)-xiayous(i)-km*L*M)/(M*(kj-km));
   if N0+shangyous(i)-xiayous(i)>= kj*L*M
      D(i)  = 120;
   else
       if N0+shangyous(i)-xiayous(i)<= km*L*M
           D(i) = 0;
       end
   end
end

%% 将时间单独作为一个输入，通行能力和上游车流结合为一个输入（通行能力是成本型）
B = [max(shangyou),min(xiayou)];
W = [min(shangyou),max(xiayou)];

%相对偏差
r(:,1) = abs(shangyou-B(1))./(max(shangyou)-min(shangyou));
r(:,2) = abs(B(2)-xiayou)./(max(xiayou)-min(xiayou));

del(:,1) = abs(shangyou-W(1))./(max(shangyou)-min(shangyou));
del(:,2) = abs(W(2)-xiayou)./(max(xiayou)-min(xiayou));

for i = 1:2
    c(i) = (r(:,i)'*del(:,i))./(norm(r(:,i))*norm(del(:,i)));
end

%权重
w(1) = c(1)/sum(c);
w(2) = c(2)/sum(c);


%无量纲化后加权求和
P(:,1) = (shangyou-min(shangyou))./(max(shangyou)-min(shangyou));
P(:,2) = (max(xiayou)-xiayou)./(max(xiayou)-min(xiayou));

score = P*w';

%% 网络结构建立
%读取数据
p=[score(5:81)';time(5:81)'];  %输入数据矩阵
t=length(5:81)';         %目标数据矩阵

%节点个数
inputnum=2;
hiddennum=5;
outputnum=1;

%训练数据和预测数据
% input_train=input(1:1900,:)';
% input_test=input(1901:2000,:)';
% output_train=output(1:1900)';
% output_test=output(1901:2000)';

%选连样本输入输出数据归一化
[inputn,PS1]=mapminmax(p);
[outputn,PS2]=mapminmax(t);

%构建网络
net=newff(inputn,outputn,hiddennum);

%% 遗传算法参数初始化
maxgen=10;                         %进化代数，即迭代次数
sizepop=10;                        %种群规模
pcross=[0.3];                       %交叉概率选择，0和1之间
pmutation=[0.1];                    %变异概率选择，0和1之间

%节点总数
	numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;

lenchrom=ones(1,numsum);        
bound=[-3*ones(numsum,1) 3*ones(numsum,1)];    %数据范围

%------------------------------------------------------种群初始化--------------------------------------------------------
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);  %将种群信息定义为一个结构体
avgfitness=[];                      %每一代种群的平均适应度
bestfitness=[];                     %每一代种群的最佳适应度
bestchrom=[];                       %适应度最好的染色体
%初始化种群
for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound);    %编码（binary和grey的编码结果为一个实数，float的编码结果为一个实数向量）
    x=individuals.chrom(i,:);
    %计算适应度
    individuals.fitness(i)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   %染色体的适应度
end

%找最好的染色体
[bestfitness bestindex]=min(individuals.fitness);
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=[avgfitness bestfitness]; 
 
%% 迭代求解最佳初始阀值和权值
% 进化开始
for i=1:maxgen
            
    % 选择
    individuals=Select(individuals,sizepop); 
    avgfitness=sum(individuals.fitness)/sizepop;
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    % 变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    
    % 计算适应度 
    for j=1:sizepop
        x=individuals.chrom(j,:); %解码
        individuals.fitness(j)=fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn);   
    end
    
  %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(individuals.fitness)/sizepop;
    
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度

end
%% 遗传算法结果分析 
 figure(1)
[r c]=size(trace);
plot([1:r]',trace(:,2),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('适应度');
legend('平均适应度','最佳适应度');
disp('适应度                   变量');
x=bestchrom;

%% 把最优初始阀值权值赋予网络预测
% %用遗传算法优化的BP网络进行值预测
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=B2;

%% BP网络训练
%网络进化参数
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
%net.trainParam.goal=0.00001;

%网络训练
[net,per2]=train(net,inputn,outputn);

%% BP网络预测
[m1,m2] = meshgrid(linspace(0.25,0.86,1040),0:1:1039);
test = [reshape(m1,1,size(m1,1)*size(m1,2));reshape(m2,1,size(m2,1)*size(m2,2))];
pn1 = mapminmax('apply',test,PS1);
an=sim(net,pn1);           %用训练好的模型进行仿真
a=mapminmax('reverse',an,PS2); % 把仿真得到的数据还原为原始的数量级；
a = reshape(a,size(m1,1),size(m1,2));
a(find(a<0)) = 0;
figure;
mesh(m1,m2,a);
grid on;
xlabel('得分');ylabel('持续时间'):zlabel('排队长度');