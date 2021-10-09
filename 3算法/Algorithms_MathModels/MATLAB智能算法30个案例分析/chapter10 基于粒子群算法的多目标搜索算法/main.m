%% 该函数演示多目标perota优化问题
%清空环境
clc
clear

load data


%% 初始参数
objnum=size(P,1); %类中物品个数
weight=92;        %总重量限制

%初始化程序
Dim=5;     %粒子维数
xSize=50;  %种群个数
MaxIt=200; %迭代次数
c1=0.8;    %算法参数
c2=0.8;    %算法参数 
wmax=1.2;  %惯性因子
wmin=0.1;  %惯性因子

x=unidrnd(4,xSize,Dim);  %粒子初始化
v=zeros(xSize,Dim);      %速度初始化

xbest=x;           %个体最佳值
gbest=x(1,:);      %粒子群最佳位置

% 粒子适应度值 
px=zeros(1,xSize);   %粒子价值目标
rx=zeros(1,xSize);   %粒子体积目标
cx=zeros(1,xSize);   %重量约束

% 最优值初始化
pxbest=zeros(1,xSize); %粒子最优价值目标
rxbest=zeros(1,xSize); %粒子最优体积目标
cxbest=zeros(1,xSize);  %记录重量，以求约束

% 上一次的值
pxPrior=zeros(1,xSize);%粒子价值目标
rxPrior=zeros(1,xSize);%粒子体积目标
cxPrior=zeros(1,xSize);%记录重量，以求约束

%计算初始目标向量
for i=1:xSize
    for j=1:Dim %控制类别
        px(i) = px(i)+P(x(i,j),j);  %粒子价值
        rx(i) = rx(i)+R(x(i,j),j);  %粒子体积
        cx(i) = cx(i)+C(x(i,j),j);  %粒子重量
    end
end
% 粒子最优位置
pxbest=px;rxbest=rx;cxbest=cx;

%% 初始筛选非劣解
flj=[];
fljx=[];
fljNum=0;
%两个实数相等精度
tol=1e-7;
for i=1:xSize
    flag=0;  %支配标志
    for j=1:xSize  
        if j~=i
            if ((px(i)<px(j)) &&  (rx(i)>rx(j))) ||((abs(px(i)-px(j))<tol)...
                    &&  (rx(i)>rx(j)))||((px(i)<px(j)) &&  (abs(rx(i)-rx(j))<tol)) || (cx(i)>weight) 
                flag=1;
                break;
            end
        end
    end
    
    %判断有无被支配
    if flag==0
        fljNum=fljNum+1;
        % 记录非劣解
        flj(fljNum,1)=px(i);flj(fljNum,2)=rx(i);flj(fljNum,3)=cx(i);
        % 非劣解位置
        fljx(fljNum,:)=x(i,:); 
    end
end

%% 循环迭代
for iter=1:MaxIt
    
    % 权值更新
    w=wmax-(wmax-wmin)*iter/MaxIt;
     
    %从非劣解中选择粒子作为全局最优解
    s=size(fljx,1);       
    index=randi(s,1,1);  
    gbest=fljx(index,:);

    %% 群体更新
    for i=1:xSize
        %速度更新
        v(i,:)=w*v(i,:)+c1*rand(1,1)*(xbest(i,:)-x(i,:))+c2*rand(1,1)*(gbest-x(i,:));
        
        %位置更新
        x(i,:)=x(i,:)+v(i,:);
        x(i,:) = rem(x(i,:),objnum)/double(objnum);
        index1=find(x(i,:)<=0);
        if ~isempty(index1)
            x(i,index1)=rand(size(index1));
        end
        x(i,:)=ceil(4*x(i,:));        
    end
    
    %% 计算个体适应度
    pxPrior(:)=0;
    rxPrior(:)=0;
    cxPrior(:)=0;
    for i=1:xSize
        for j=1:Dim %控制类别
            pxPrior(i) = pxPrior(i)+P(x(i,j),j);  %计算粒子i 价值
            rxPrior(i) = rxPrior(i)+R(x(i,j),j);  %计算粒子i 体积
            cxPrior(i) = cxPrior(i)+C(x(i,j),j);  %计算粒子i 重量
        end
    end
    
    %% 更新粒子历史最佳
    for i=1:xSize
        %现在的支配原有的，替代原有的
         if ((px(i)<pxPrior(i)) &&  (rx(i)>rxPrior(i))) ||((abs(px(i)-pxPrior(i))<tol)...
                 &&  (rx(i)>rxPrior(i)))||((px(i)<pxPrior(i)) &&  (abs(rx(i)-rxPrior(i))<tol)) || (cx(i)>weight) 
                xbest(i,:)=x(i,:);%没有记录目标值
                pxbest(i)=pxPrior(i);rxbest(i)=rxPrior(i);cxbest(i)=cxPrior(i);
          end
        
        %彼此不受支配，随机决定
        if ~( ((px(i)<pxPrior(i)) &&  (rx(i)>rxPrior(i))) ||((abs(px(i)-pxPrior(i))<tol)...
                &&  (rx(i)>rxPrior(i)))||((px(i)<pxPrior(i)) &&  (abs(rx(i)-rxPrior(i))<tol)) || (cx(i)>weight) )...
                &&  ~( ((pxPrior(i)<px(i)) &&  (rxPrior(i)>rx(i))) ||((abs(pxPrior(i)-px(i))<tol) &&  (rxPrior(i)>rx(i)))...
                ||((pxPrior(i)<px(i)) &&  (abs(rxPrior(i)-rx(i))<tol)) || (cxPrior(i)>weight) )
            if rand(1,1)<0.5
                xbest(i,:)=x(i,:);
                  pxbest(i)=pxPrior(i);rxbest(i)=rxPrior(i);cxbest(i)=cxPrior(i);
            end
        end
    end

    %% 更新非劣解集合
    px=pxPrior;
    rx=rxPrior;
    cx=cxPrior;
    %更新升级非劣解集合
    s=size(flj,1);%目前非劣解集合中元素个数
   
    %先将非劣解集合和xbest合并
    pppx=zeros(1,s+xSize);
    rrrx=zeros(1,s+xSize);
    cccx=zeros(1,s+xSize);
    pppx(1:xSize)=pxbest;pppx(xSize+1:end)=flj(:,1)';
    rrrx(1:xSize)=rxbest;rrrx(xSize+1:end)=flj(:,2)';
    cccx(1:xSize)=cxbest;cccx(xSize+1:end)=flj(:,3)';
    xxbest=zeros(s+xSize,Dim);
    xxbest(1:xSize,:)=xbest;
    xxbest(xSize+1:end,:)=fljx;
   
    %筛选非劣解
    flj=[];
    fljx=[];
    k=0;
    tol=1e-7;
    for i=1:xSize+s
        flag=0;%没有被支配
        %判断该点是否非劣
        for j=1:xSize+s 
            if j~=i
                if ((pppx(i)<pppx(j)) &&  (rrrx(i)>rrrx(j))) ||((abs(pppx(i)-pppx(j))<tol) ...
                        &&  (rrrx(i)>rrrx(j)))||((pppx(i)<pppx(j)) &&  (abs(rrrx(i)-rrrx(j))<tol)) ...
                        || (cccx(i)>weight) %有一次被支配
                    flag=1;
                    break;
                end
            end
        end

        %判断有无被支配
        if flag==0
            k=k+1;
            flj(k,1)=pppx(i);flj(k,2)=rrrx(i);flj(k,3)=cccx(i);%记录非劣解
            fljx(k,:)=xxbest(i,:);%非劣解位置
        end
    end
    
    %去掉重复粒子
    repflag=0;   %重复标志
    k=1;         %不同非劣解粒子数
    flj2=[];     %存储不同非劣解
    fljx2=[];    %存储不同非劣解粒子位置
    flj2(k,:)=flj(1,:);
    fljx2(k,:)=fljx(1,:);
    for j=2:size(flj,1)
        repflag=0;  %重复标志
        for i=1:size(flj2,1)
            result=(fljx(j,:)==fljx2(i,:));
            if length(find(result==1))==Dim
                repflag=1;%有重复
            end
        end
        %粒子不同，存储
        if repflag==0 
            k=k+1;
            flj2(k,:)=flj(j,:);
            fljx2(k,:)=fljx(j,:);
        end
        
    end
    
    %非劣解更新
    flj=flj2;
    fljx=fljx2;

end

%绘制非劣解分布
plot(flj(:,1),flj(:,2),'o') 
xlabel('P')
ylabel('R')
title('最终非劣解在目标空间分布')
disp('非劣解flj中三列依次为P，R，C')