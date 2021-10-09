%% 文件说明
% 此程序用于求解下面问题
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 在问题1的假设下，
% 计算海面风速为36m/s时钢桶和各节钢管的倾斜角度、
% 锚链形状和浮标的游动区域。
% 请调节重物球的质量，使得钢桶的倾斜角度不超过5度，
% 锚链在锚点与海床的夹角不超过16度。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% 绘制m_qiu和y0 、x0 、alpha1、alpha2之间的关系图
clc
clear 
%定参
v_wind = 36;
%超参
H = 18;
N = 500;
x0 = 20;
I = 2;
L = 22.05;
y0_yn_figure = 0;
xitong_figure = 0;
%正文
m_qiu = linspace(1000, 6000, 100);
besty0 = zeros(size(m_qiu));
bestx0 = zeros(size(m_qiu));
alpha1 = zeros(size(m_qiu));
alpha2 = zeros(size(m_qiu));
for i = 1:length(m_qiu)
    [besty0(i), bestx0(i)] = bestpoint(H, N, x0, v_wind, m_qiu(i), I, L, y0_yn_figure);
    y0 = besty0(i);
    x0 = bestx0(i);
    [~, ~, ~, ~, stat] = For2D(y0, x0, v_wind, m_qiu(i), I, L, xitong_figure);
    alpha1(i) = stat.alpha1;
    alpha2(i) = stat.alpha2;
end
%绘图
figure(1)
plot(m_qiu, abs(besty0), 'r*-')
xlabel('重物球质量')
ylabel('吃水深度')
title('吃水深度h随重物球质量变化曲线')
title('')
figure(2)
plot(m_qiu, bestx0, 'c<-')
xlabel('重物球质量')
ylabel('浮漂横坐标')
title('浮漂横坐标随重物球质量变化曲线')

figure(3)
plot(m_qiu, alpha1, 'bo-')
xlabel('重物球质量')
ylabel('钢桶竖直夹角')
title('钢桶竖直夹角随重物球质量变化曲线')

figure(4)
plot(m_qiu, alpha2, 'gs-')
xlabel('重物球质量')
ylabel('锚链底端水平夹角')
title('锚链底端水平夹角随重物球质量变化曲线')

%注：最好插值or拟合一下。

%% 确定m_qiu的取值范围
%钢桶的倾斜角度不超过5度，锚链在锚点与海床的夹角不超过16度
alpha1_max = 5;
alpha2_max = 16;

[~, ind1] = min(abs(alpha1 - alpha1_max));
m1 = m_qiu(ind1);
[~, ind2] = min(abs(alpha2 - alpha2_max));
m2 = m_qiu(ind2);

%浮漂完全没入水中，h = 2。
ind3 = min(find(abs(besty0) == 2));%ind3 = find(abs(besty0) == 2, 1)
m3 = m_qiu(ind3);

% s.t.  max{m1, m2}  <  m  < m3

%%  IENSGAii 求解最优m_qiu，使得h、pi*x0^2和alpha1最小，且alpha1，2在范围内
fitnessfcn = @multi_GA_m;   
nvars = 1;                     
lb = max([m1, m2]);                  
ub = m3;                     
A = []; b = [];                 
Aeq = []; beq = [];             
options = gaoptimset('ParetoFraction', 0.3, 'PopulationSize', 100, 'Generations', 100, 'StallGenLimit', 100, 'PlotFcns', {@gaplotpareto, @gaplotbestf});

[x_m, fval] = gamultiobj(fitnessfcn, nvars, A, b, Aeq, beq, lb, ub, options);













