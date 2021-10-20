function test2
% 真菌扩散元胞模拟
% 木质纤维
clear,clc,close all
% 元胞自动机大小
m = 500;
n = 500;
[E,I,R] = deal(1,2,3);
% E : 未感染 : 1
% I : 被感染 : 2
% R : 被分解 : 3
%% 参数设定
rhoI = 0.1; % 初始感染密度
P1 = 0.6; % 感染概率
T = 100;% 平均分解时间
%% 
X = ones(m,n);
X(rand(m,n)<rhoI) = I;
time = zeros(m,n); % 计时：用于计算分解时间
% 邻居方位
d = {[1,0],[0,1],[-1,0],[0,-1]};
% 每个元胞分解时间服从正态分布
Tmn = normrnd(T,T/2,m,n);

%% 图形化展示
figure('position',[50,50,1200,400])
subplot(1,2,1)
h1 = imagesc(X);
colormap(jet(3))
labels = {'未感染','被感染','被分解'};
lcolorbar(labels);

subplot(1,2,2)
h2 = plot(0,[0,0,0]);
axis([0,200,0,m*n]);
legend('未感染','被感染','被分解');

%% 循环开始
M = 200;
for t = 1 : M
    % 邻居中感染的元胞
    N = zeros(size(X));
    for j = 1 : length(d)
        N = N + circshift(X,d{j}) == I; 
    end
    % 分别找出四种状态
    isR = (X == R);
    isE = (X == E);
    isI = (X == I);
     % 将四种状态的元胞数量存到 Y中  
    Y(t,:) = sum([isE(:) isI(:) isR(:)]);
    % 对被感染的进行计时
    time(isI) = time(isI) + 1;
    %% 判断规则
    % 规则一：如果未感染的邻居有N个染病的，则其以概率N*P变成被感染
    ifE_I = rand(m,n) < (N*P1);
    Rule1 = I * (isE & ifE_I) + E * (isE & ~ifE_I);
    time(isE & ifE_I) = 0;
    % 规则二：如果被感染者到达分解时间，则转为被分解
    ifI_R = time > Tmn;
    Rule2 = R * (isI & ifI_R) + I * (isI & ~ifI_R);
    % 规则三：已经被分解的，保持分解
    Rule3 = R * isR;
%     time(time > Tmn) = 0;
    % 叠加规则
    X = Rule1 + Rule2 + Rule3;
    figure(1)
    set(h1,'CData',X);
    for i = 1:3
        set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); 
    end
    drawnow
end