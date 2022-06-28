function [bestz0, besty0, bestx0] = bestpoint_3D(H, N, y0, x0, v1, v2, m_qiu, I, L, beta, z0_zn_figure)
%此函数用离散枚举法法求最优吃水深度h
% 
%%%%输入%%%%
% H：海水深度
% N：z0在[0,2]间的离散点数，决定了besty0的求解精度。
% y0：浮标初始纵坐标
% x0：浮标初始横坐标
% v1：风速
% v2：水速
% m_qiu：重物球质量
% I ：锚链型号
% L：锚链长度
% beta：风力与水力的夹角。
% z0_zn_figure：是否输出y0与yn的函数图像
%
%%%%输出%%%%
% bestz0：浮标最优z坐标
% besty0：浮标最优y坐标
% bestx0：浮标最优x坐标
%
%%%%此程序用于求解下面问题%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 由于潮汐等因素的影响，
% 布放海域的实测水深介于16m~20m之间。
% 布放点的海水速度最大可达到1.5m/s、风速最大可达到36m/s。
% 请给出考虑风力、水流力和水深情况下的系泊系统设计，
% 分析不同情况下钢桶、钢管的倾斜角度、锚链形状、浮标的吃水深度和游动区域。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%默认输入
if nargin < 11
    z0_zn_figure = 0;
end
if nargin < 10
    beta = pi/2;
end
if nargin < 9
    L = 22.05;
end
if nargin < 8
    I = 2;
end
if nargin < 7
    m_qiu = 500;
end
if nargin < 6
    v2 = 1.5;
end
if nargin < 5
    v1 = 12;
end
if nargin < 4
    x0 = -5;
end
if nargin < 3
    y0 = 20;
end
if nargin < 2
    N = 100;
end
if nargin < 1
    H = 18;
end

%%%%正文%%%%

z0 = linspace(0, -2, N);
%注：z0是有取值范围的，z0不可以从0开始取值，否则会发生zn>0的情况。
%修正z0
rho = 1.025*10^3;%海水的密度  kg/m^3
D = 2;%圆柱浮标地面直径 m
m0 = 1000;%浮标质量 kg
z0_min = -(m0 + m_qiu)/(rho*pi*(D/2)^2);
z0 = linspace(z0_min, -2, N);

zn = zeros(size(z0));
yn = zeros(size(z0));
xn = zeros(size(z0));
thetan = zeros(size(z0));
alphan = zeros(size(z0));
xitong_figure = 0;
for i = 1:length(z0)
    [z, y, x, theta, alpha, ~, ~] = For3D(z0(i),y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure);
    zn(i) =  z(end);
    yn(i) =  y(end);
    xn(i) =  x(end);
    thetan(i) = theta(end - 1);
    alphan(i) = alpha(end - 1);
end

[~, ind1] = min(abs(zn - (-H)));
bestz0 = z0(ind1);
besty0 = y0 - yn(ind1);
bestx0 = x0 - xn(ind1);

%绘制y0与yn的函数图
if z0_zn_figure == 1
    figure
    plot(abs(z0), zn, 'r*-')
    xlabel('吃水深度')
    ylabel('锚链末端坐标')
    title('锚链末端zn随吃水深度h的变化曲线图')
    
    figure
    plot(abs(z0), thetan, 'g*-')
    xlabel('吃水深度')
    ylabel('锚链末端水平面夹角')
    title('锚链末端水平面夹角随吃水深度h的变化曲线图')    
end
end










