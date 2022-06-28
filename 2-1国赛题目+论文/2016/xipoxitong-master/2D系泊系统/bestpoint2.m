function [besty0, bestx0, bestyn] = bestpoint2(y0, x0, H, eta, maxt, eps, v_wind, m_qiu, I, L)
%此函数用迭代算法求最优吃水深度h
% 
%%%%输入%%%%
% y0：初始浮标纵坐标
% x0：初始浮标初始横坐标
% H：水深
% eta：学习率
% maxt：最大迭代次数
% eps：求解精度
% v_wind：风速
% m_qiu：重物球质量
% I ：锚链型号
% L：锚链长度
%
%%%%输出%%%%
% besty0：浮标最优纵坐标
% bestx0：浮标最优横坐标
% bestyn：锚链末端纵坐标
%
%%%%此程序用于求解下面问题%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 某型传输节点选用II型电焊锚链22.05m，
% 选用的重物球的质量为1200kg。
% 现将该型传输节点布放在水深18m、
% 海床平坦、海水密度为1.025×103kg/m3的海域。
% 若海水静止，分别计算海面风速为12m/s和24m/s时钢桶和
% 各节钢管的倾斜角度、锚链形状、浮标的吃水深度和游动区域
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%%%%默认输入%%%%
if nargin < 10
    L = 22.05;%锚链长度 m
end
if nargin < 9
    I = 2;
end
if nargin < 8
    m_qiu = 1200;
end
if nargin < 7
    v_wind = 12;
end
if nargin < 6
    eps = 0.01;
end
if nargin < 5
    maxt = 500;
end
if nargin < 4
    eta = 0.001;
end
if nargin < 3
    H = 18;
end
if nargin < 2
    x0 = 20;
end
if nargin < 1
    y0 = 2*rand;
end

%%%%正文%%%%
xitong_figure = 0;
t = 0;
while t < maxt
    [~, ~, ~, ~, stat] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);
    yn = stat.yn;
    xn = stat.xn;
    delta_yn = yn - (-H);
    if abs(delta_yn) < eps
        disp('yn满足精度，终止')
        break;
    else
        y1 = y0;
        y0 = y0 - eta*delta_yn;%更新y0
        %如果y0不在范围内
        if y0 < -2 | y0 > 0
            eta1 = 0.5*eta;
            y0 = y1 - eta1*delta_yn;
        end
    end
    t = t+1;
    if t == maxt
        disp('达到最大迭代次数，终止')
    end
end

%%%%构建输出%%%%
disp(['迭代次数：', num2str(t)])
besty0 = y0;
bestyn = yn;
bestx0 = x0 - xn;

























