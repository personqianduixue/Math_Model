function test7
% 第二问--真菌扩散元胞模拟
% 考虑菌群间竞争作用
    % 对于每种菌，另外两种菌种均会对其进行削弱
    % 削弱比例：n/N
% 多种菌丝--地面腐殖物
% 绘制dN/dt

clear,clc,close all
% 元胞自动机大小
m = 500;
n = 500;
[E,I1,R,I2,I3] = deal(1,2,3,4,5);
% E : 未感染 : 1
% I1 : 被感染1 : 2
% I2 : 被感染2 : 4
% I3 : 被感染3 : 5
% R : 被分解 : 3
%% 参数设定
rhoI1 = 0.0002; % 初始感染密度
p1 = 0.3; % 感染概率
T1 = 20;% 平均分解时间
rhoI2 = 0.0002; % 初始感染密度
p2 = 0.4; % 感染概率
T2 = 50;% 平均分解时间
rhoI3 = 0.0002; % 初始感染密度
p3 = 0.2; % 感染概率
T3 = 20;% 平均分解时间
P4 = 0.3; % 落叶概率
%% 
X = ones(m,n);
c1 = rhoI1*(1-rhoI2)*(1-rhoI3);
c2 = rhoI2*(1-rhoI1)*(1-rhoI3);
c3 = rhoI3*(1-rhoI2)*(1-rhoI1);
c4 = (1-rhoI1)*(1-rhoI2)*(1-rhoI3);
ifr = rand(m,n);
X(ifr<=c1/(c1+c2+c3+c4)) = I1;
X(ifr>c1/(c1+c2+c3+c4) & ifr<=(c1+c2)/(c1+c2+c3+c4)) = I2;
X(ifr>(c1+c2)/(c1+c2+c3+c4) & ifr<=(c1+c2+c3)/(c1+c2+c3+c4)) = I3;
XX = zeros(m+2,n+2);
XX(2:m+1,2:n+1) = X;
time1 = zeros(m,n); % 计时：用于计算分解时间
time2 = zeros(m,n); % 计时：用于计算分解时间
time3 = zeros(m,n); % 计时：用于计算分解时间

% 每个元胞分解时间服从正态分布
Tmn1 = normrnd(T1,T1/2,m,n);
Tmn2 = normrnd(T2,T2/2,m,n);
Tmn3 = normrnd(T3,T3/2,m,n);
%% 图形化展示
figure('position',[50,50,1200,400])
subplot(1,2,1)
h1 = imagesc(X);
colormap(jet(5))
labels = {'未感染','被感染1','被分解','被感染2','被感染3'};
lcolorbar(labels);

subplot(1,2,2)
h2 = plot(0,[0,0,0]);
% axis([0,200,0,m*n]);
legend('被感染1','被感染2','被感染3');

%% 循环开始
M = 1e3;
for t = 1 : M
    XX = zeros(m+2,n+2);
    XX(2:m+1,2:n+1) = X;
    Sd = XX;
    % 邻居中感染的元胞
    N1=(Sd(1:n,2:n+1)==I1)+(Sd(3:n+2,2:n+1)==I1)+(Sd(2:n+1,1:n)==I1)+(Sd(2:n+1,3:n+2)==I1)+(Sd(1:n,1:n)==I1)+(Sd(3:n+2,1:n)==I1)+(Sd(1:n,3:n+2)==I1)+(Sd(3:n+2,3:n+2)==I1);  % 邻居之和
    N2=(Sd(1:n,2:n+1)==I2)+(Sd(3:n+2,2:n+1)==I2)+(Sd(2:n+1,1:n)==I2)+(Sd(2:n+1,3:n+2)==I2)+(Sd(1:n,1:n)==I2)+(Sd(3:n+2,1:n)==I2)+(Sd(1:n,3:n+2)==I2)+(Sd(3:n+2,3:n+2)==I2);  % 邻居之和
    N3=(Sd(1:n,2:n+1)==I3)+(Sd(3:n+2,2:n+1)==I3)+(Sd(2:n+1,1:n)==I3)+(Sd(2:n+1,3:n+2)==I3)+(Sd(1:n,1:n)==I3)+(Sd(3:n+2,1:n)==I3)+(Sd(1:n,3:n+2)==I3)+(Sd(3:n+2,3:n+2)==I3);  % 邻居之和
    % 分别找出状态
    isR = (X == R);
    isE = (X == E);
    isI1 = (X == I1);
    isI2 = (X == I2);
    isI3 = (X == I3);
    % 对被感染的进行计时
    time1(isI1) = time1(isI1) + 1;
    time2(isI2) = time2(isI2) + 1;
    time3(isI3) = time3(isI3) + 1;
    time1(~isI1) = 0;
    time2(~isI2) = 0;
    time3(~isI3) = 0;
    
    if t == 1
        [P1,P2,P3] = deal(p1,p2,p3);
    end
    %% 判断规则
    % 规则一：如果未感染的邻居有N个染病的，则其以概率N*P变成被感染
    % 对于多种真菌，以归一化后的概率来判断
    ifc = rand(m,n);% 设定矩阵，用于归一化判断概率
    % 感染1的概率
    c1 = (N1*P1)./(N1*P1+N2*P2+N3*P3).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    % 感染2的概率
    c2 = (N2*P2)./(N1*P1+N2*P2+N3*P3).*(1-N1*P1./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    % 感染3的概率
    c3 = (N3*P3)./(N1*P1+N2*P2+N3*P3).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N1*P1./(N1*P1+N2*P2+N3*P3));
    % 不感染的概率
    c4 = (1-N1*P1./(N1*P1+N2*P2+N3*P3)).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    ifE_I1 = (ifc <= c1./(c1+c2+c3+c4));
    ifE_I2 = (ifc > c1./(c1+c2+c3+c4) & ifc <= c1+c2./(c1+c2+c3+c4));
    ifE_I3 = (ifc > c1+c2./(c1+c2+c3+c4) & ifc <= c1+c2+c3./(c1+c2+c3+c4));
    ifE_I4 = (ifc > c1+c2+c3./(c1+c2+c3+c4));
    Rule1 = I1 * (isE & ifE_I1) + I2 * (isE & ifE_I2) + I3 * (isE & ifE_I3) + E * (isE & ifE_I4);
    time1(isE & ifE_I1) = 0;
    time2(isE & ifE_I2) = 0;
    time3(isE & ifE_I3) = 0;
    
    % 规则二：如果被感染者到达分解时间，则转为被分解
    %1
    ifI1_R = time1 > Tmn1;
    Rule2_1 = R * (isI1 & ifI1_R) + I1 * (isI1 & ~ifI1_R);
    %2
    ifI2_R = time2 > Tmn2;
    Rule2_2 = R * (isI2 & ifI2_R) + I2 * (isI2 & ~ifI2_R);
    %3
    ifI3_R = time3 > Tmn3;
    Rule2_3 = R * (isI3 & ifI3_R) + I3 * (isI3 & ~ifI3_R);
    
    % 规则三：已经被分解的，以一定概率转为未感染
    ifR_E = rand(m,n) < P4;
    Rule3 = E * (isR & ifR_E) + R * (isR & ~ifR_E);
    
    % 叠加规则
    X = Rule1 + Rule2_1 + Rule2_2 + Rule2_3 + Rule3;
    
    % 修正传播概率
    NN = sum(isI1(:)) + sum(isI2(:)) + sum(isI3(:));
    P1 = (1-sum(isI2(:))/NN)*(1-sum(isI3(:))/NN)*p1;
    P2 = (1-sum(isI1(:))/NN)*(1-sum(isI3(:))/NN)*p2;
    P3 = (1-sum(isI1(:))/NN)*(1-sum(isI2(:))/NN)*p3;
    
    % 将四种状态的元胞数量存到 Y中  
    Y(t,:) = sum([isR(:) isE(:) isI1(:) isI2(:) isI3(:)]);
    if t > 1
        YY(t,:) = Y(t,:) - Y(t-1,:);
    else
        YY(t,:) = Y(t,:);
    end
    figure(1)
    set(h1,'CData',X);
    for i = 3:5
        set(h2(i-2), 'XData', 1:t, 'YData', YY(1:t,i)); 
    end
    drawnow
end