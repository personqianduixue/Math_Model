% 脚本 main_xor.m
% 批量训练方式。BP网络实现异或逻辑。
% 误差曲线  分类面

%% 清理
clear all 
clc 
rng('default')
rng(0)

%% 参数
eb = 0.01;                   % 误差容限 
eta = 0.6;                   % 学习率
mc = 0.8;                    % 动量因子 
maxiter = 1000;              % 最大迭代次数

%% 初始化网络
nSampNum = 4; 
nSampDim = 2; 
nHidden = 3;    
nOut = 1; 
w = 2*(rand(nHidden,nSampDim)-1/2); 
b = 2*(rand(nHidden,1)-1/2); 
wex = [w,b]; 
 
W = 2*(rand(nOut,nHidden)-1/2); 
B = 2*(rand(nOut,1)-1/2); 
WEX = [W,B]; 

%% 数据
SampIn=[0,0,1,1;...
        0,1,0,1;...
        1,1,1,1];
expected=[0,1,1,0];

%% 训练
iteration = 0; 
errRec = []; 
outRec = []; 
 
for i = 1 : maxiter    
    % 工作信号正向传播
    hp = wex*SampIn;        
    tau = logsig(hp);      
    tauex  = [tau', 1*ones(nSampNum,1)]';    
     
    HM = WEX*tauex;    
    out = logsig(HM);   
    outRec = [outRec,out']; 
     
    err = expected - out; 
    sse = sumsqr(err);       
    errRec = [errRec,sse];
    fprintf('第 %d 次迭代，误差： %f \n',i,sse ) 
     
    % 判断是否收敛
    iteration = iteration + 1;              
    if sse <= eb 
        break;
    end 
     
    % 误差信号反向传播
    % DELTA和delta为局部梯度 
    DELTA = err.*dlogsig(HM,out);            
    delta = W' * DELTA.*dlogsig(hp,tau);      
    dWEX = DELTA*tauex'; 
    dwex = delta*SampIn'; 
    
    % 更新权值
    if i == 1 
        WEX = WEX + eta * dWEX; 
        wex = wex + eta * dwex; 
    else    
        WEX = WEX + (1 - mc)*eta*dWEX + mc * dWEXOld; 
        wex = wex + (1 - mc)*eta*dwex + mc * dwexOld; 
    end 
    
    dWEXOld = dWEX; 
    dwexOld = dwex; 
   
    W  = WEX(:,1:nHidden); 
    
end      

%% 显示

figure(1)
grid 
[nRow,nCol] = size(errRec); 
semilogy(1:nCol,errRec,'LineWidth',1.5); 
title('误差曲线'); 
xlabel('迭代次数'); 

x=-0.2:.05:1.2;
[xx,yy]=meshgrid(x);
for i=1:length(xx)
   for j=1:length(yy)
       xi=[xx(i,j),yy(i,j),1];
       hp = wex*xi';
       tau = logsig(hp);
       tauex  = [tau', 1]'; 
       HM = WEX*tauex;  
       out = logsig(HM); 
       z(i,j)=out;
   end
end
figure(2)
mesh(x,x,z);
figure(3)
plot([0,1],[0,1],'*','LineWidth',2);
hold on
plot([0,1],[1,0],'o','LineWidth',2);
[C,h]=contour(x,x,z,0.5,'b');
clabel(C,h);
legend('0','1','分类面');
title('分类面')

