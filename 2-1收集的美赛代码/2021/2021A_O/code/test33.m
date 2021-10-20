function test33
% 黄曲霉
% 真菌扩散元胞模拟
% 单种菌丝--地面腐殖物
clear,clc,close all
% 元胞自动机大小
m = 500;
n = 500;
[S,E,I,R] = deal(0,1,2,3);
TT = [24.4 26.12 26.63 26.07 28.72];
HH = [29.65 39.63 56.99 69.45 88.69]/100;
for iii = 1 : 5
% S : 空地   : 0
% E : 未感染 : 1
% I : 被感染 : 2
% R : 被分解 : 3
%% 参数设定
T_real = TT(iii);
H_real = HH(iii);
% T_real = 29.4;
% H_real = 0.4665;
Vemax = 8.6;   % 需要调整
% T = 24; % 最适温度
% H = 0.92;
% T = 24.2; % 最适温度
% H = 0.90;
T = 32; % 最适温度
H = 0.8;
if T >= T_real
    Ve = Vemax.*exp(-Vemax/(H_real.*T_real));
else
	Ve = Vemax.*exp(-Vemax/(H_real.*(2*T-T_real)));
end
M = 2*H-1;
% M = 0.7;
Vd = T_real*Ve.^0.5+31.90*1.26.^M-64.80*ones(size(Ve));
P1 = 1/(1+exp(-1/Ve))/10;
% if iii == 1
%     P1 = 1/(1+exp(-1/Ve))/50;
% end

rhoI = 0.06; % 初始感染密度
% P1 = 0.2; % 感染概率
% T = 30;% 平均分解时间
T = Vd;
P2 = 0.1; % 落叶概率
%% 
X = ones(m,n);
X(rand(m,n)<rhoI) = I;
time = zeros(m,n); % 计时：用于计算分解时间
% 邻居方位
d = {[1,0],[0,1],[-1,0],[0,-1]};
% 每个元胞分解时间服从正态分布
Tmn = normrnd(T,T/2,m,n);

%% 图形化展示
% h2 = plot(0,[0],'linewidth',1);
% % axis([0,200,0,m*n]);
% legend('被感染');

%% 循环开始
M = 1e3;
NR = 0;
for t = 1 : M
    % 邻居中感染的元胞
    N = zeros(size(X));
    for j = 1 : length(d)
        N = N + circshift(X,d{j}) == I; 
    end
    % 分别找出四种状态
    isS = (X == R);
    isE = (X == E);
    isI = (X == I);
    % 对被感染的进行计时
    time(isI) = time(isI) + 1;
    time(isE) = 0;
    time(isS) = 0;
    %% 判断规则
    % 规则一：如果未感染的邻居有N个染病的，则其以概率N*P变成被感染
    ifE_I = rand(m,n) < (N*P1);
    Rule1 = I * (isE & ifE_I) + E * (isE & ~ifE_I);
    time(isE & ifE_I) = 0;
    % 规则二：如果被感染者到达分解时间，则转为被分解
    ifI_R = time > Tmn;
    Rule2 = R * (isI & ifI_R) + I * (isI & ~ifI_R);
    temp = (isI & ifI_R);
    NR = NR + sum(temp(:));
    % 规则三：已经被分解的，以一定概率转为未感染
    ifS_E = rand(m,n) < P2;
    Rule3 = E * (isS & ifS_E) + R * (isS & ~ifS_E);

    % 叠加规则
    X = Rule1 + Rule2 + Rule3;
    
    % 将四种状态的元胞数量存到 Y中  

    Y(t,iii) = sum(isI(:));
%     for i = 1:1
%         set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); 
%     end
    if t == 100
       break; 
    end
%     drawnow
end
end
plot(Y,'linewidth',2)
% title('Trichoderma')
title('Aspergillus')
xlabel('Day')
% axis([0,100,0,82000])
legend('Arid area','Semi arid area','Temperate zone','Arboreal area','Tropical rain forest')
