function [besty0, bestx0] = bestpoint(H, N, x0, v_wind, m_qiu, I, L, y0_yn_figure)
%此函数用离散枚举法求最优吃水深度h
%
%%%%输入%%%%
% H：海水深度
% N：y0在[0,2]间的离散点数，决定了besty0的求解精度。
% x0：浮标初始横坐标
% v_wind：风速
% m_qiu：重物球质量
% I ：锚链型号
% L：锚链长度
% y0_yn_figure：是否输出y0与yn的函数图像
%
%%%%输出%%%%
% besty0：浮标最优纵坐标
% bestx0：浮标最优横坐标
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

%默认输入
if nargin < 8
    y0_yn_figure = 0;
end
if nargin < 7
    L = 22.05;
end
if nargin < 6
    I = 2;
end
if nargin < 5
    m_qiu = 1200;
end
if nargin < 4
    v_wind = 12;
end
if nargin < 3
    x0 = 20;
end
if nargin < 2
    N = 2000;
end
if nargin < 1
    H = 18;
end

%%%%正文%%%%

y0 = linspace(0, -2, N);
%注：y0是有取值范围的，y0不可以从0开始取值，否则会发生yn>0的情况。
%修正y0
rho = 1.025*10^3;%海水的密度  kg/m^3
D = 2;%圆柱浮标地面直径 m
m0= 1000;%浮标质量 kg
y0_min = -(m0+m_qiu)/(rho*pi*(D/2)^2);
y0 = linspace(y0_min, -2, N);

yn = zeros(size(y0));
xn = zeros(size(y0));
xitong_figure = 0;
for i = 1:length(y0)
    [y, x, theta, ~] = For2D(y0(i), x0, v_wind, m_qiu, I, L, xitong_figure);
    yn(i) =  y(end);
    xn(i) =  x(end);
    thetan(i) = theta(end - 1);
end

[~, ind1] = min(abs(yn - (-H)));
besty0 = y0(ind1);
bestx0 = x0 - xn(ind1);

%绘制y0与yn的函数图
if y0_yn_figure == 1
    figure
    plot(abs(y0), yn, 'r*-')
    xlabel('吃水深度')
    ylabel('锚链末端坐标')
    title('锚链末端yn随吃水深度h的变化曲线图')

    figure
    plot(abs(y0), thetan, 'g*-')
    xlabel('吃水深度')
    ylabel('锚链末端水平夹角')
    title('锚链末端水平夹角随吃水深度h的变化曲线图')
end
end










