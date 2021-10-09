clc
clear all
close all
tic
figure(1);hold on
%% 参数设置
fishnum=100; %生成100只人工鱼
MAXGEN=50; %最多迭代次数
try_number=100;%最多试探次数
visual=1; %感知距离
delta=0.618; %拥挤度因子
step=0.1; %步长
%% 初始化鱼群
lb_ub=[-10,10,2;];
X=AF_init(fishnum,lb_ub);
LBUB=[];
for i=1:size(lb_ub,1)
    LBUB=[LBUB;repmat(lb_ub(i,1:2),lb_ub(i,3),1)];
end
gen=1;
BestY=-1*ones(1,MAXGEN); %每步中最优的函数值
BestX=-1*ones(2,MAXGEN); %每步中最优的自变量
besty=-100; %最优函数值
Y=AF_foodconsistence(X);
while gen<=MAXGEN
    fprintf(1,'%d\n',gen)
    for i=1:fishnum
        %% 聚群行为
        [Xi1,Yi1]=AF_swarm(X,i,visual,step,delta,try_number,LBUB,Y); 
        
         %% 追尾行为
        [Xi2,Yi2]=AF_follow(X,i,visual,step,delta,try_number,LBUB,Y);
        if Yi1>Yi2
            X(:,i)=Xi1;
            Y(1,i)=Yi1;
        else
            X(:,i)=Xi2;
            Y(1,i)=Yi2;
        end
    end
    [Ymax,index]=max(Y);
    figure(1);
    plot(X(1,index),X(2,index),'.','color',[gen/MAXGEN,0,0])
    if Ymax>besty
        besty=Ymax;
        bestx=X(:,index);
        BestY(gen)=Ymax;
        [BestX(:,gen)]=X(:,index);
    else
        BestY(gen)=BestY(gen-1);
        [BestX(:,gen)]=BestX(:,gen-1);
    end
    gen=gen+1;
end
plot(bestx(1),bestx(2),'ro','MarkerSize',100)
xlabel('x')
ylabel('y')
title('鱼群算法迭代过程中最优坐标移动')

%% 优化过程图
figure
plot(1:MAXGEN,BestY)
xlabel('迭代次数')
ylabel('优化值')
title('鱼群算法迭代过程')
disp(['最优解X：',num2str(bestx','%1.5f')])
disp(['最优解Y：',num2str(besty,'%1.5f')])
toc