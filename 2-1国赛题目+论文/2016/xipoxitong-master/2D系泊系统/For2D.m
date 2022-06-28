function [y, x, theta, T, stat] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure)
% 此函数用于给定x0和y0后求解系泊系统的状态曲线
%
%%%%输入%%%%
% y0：浮标纵坐标，|y0|=h。其中，h为吃水深度。
% x0：浮标横坐标。
% v_wind：风速。
% m_qiu：重物球质量。
% I：锚链型号。1、2、3、4、5
% L：锚链长度。
% outputfigure：是否输出系统图像。logistic
%
%%%%输出%%%%
% y：系泊系统纵坐标。向量
% x：系泊系统横坐标。
% theta：系泊系统角度。
% T：系泊系统拉力。
% stat：要求的系泊系统参数，包括：吃水深度h、横坐标x0、游动区域S、钢桶竖直夹角alpha1、锚链底端水平夹角alpha2、风速v_wind、重物球质量m、系统状态yxthetaT。stats

%默认输入
if nargin < 7
    xitong_figure = 0;
end
if nargin < 6
    L = 22.05;%锚链长度 m
end
if nargin < 5
    I = 2;
end
if nargin < 4
    m_qiu = 1200;
end
if nargin < 3
    v_wind = 12;
end
if nargin < 2
    x0 = 20;
end
if nargin < 1
    disp('请输入参数')
    return;
end

%%%%正文%%%%
%确定锚链
switch I 
    case 1
       II = 78/1000;%锚链每节长度 m
       m_II = 3.2;%单位长度的质量 kg/m
    case 2
       II = 105/1000;%锚链每节长度 m
       m_II = 7;%单位长度的质量 kg/m
    case 3
       II = 120/1000;
       m_II = 12.5;%单位长度的质量 kg/m
    case 4
        II = 150/1000;
        m_II = 19.5;%单位长度的质量 kg/m
    case 5
        II = 180/1000;
        m_II = 28.12;%单位长度的质量 kg/m
end
n = round(L/II);
ind = n+5+1;

y(1) = y0;
x(1) = x0; 
h = abs(y(1));%浮标吃水深度

%浮标受力
rho = 1.025*10^3;%海水的密度  kg/m^3
g = 9.8;%重力加速度 N/kg
D = 2;%圆柱浮标地面直径 m
h0 = 2;%圆柱浮标高度 m
m0= 1000;%浮标质量 kg
F0 = rho*g*pi*(D/2)^2*h;%浮标浮力
G0 = m0*g;%浮标重力
%v_wind = 12;%风速 m/s
S_wind = D*(h0-h);%风受力面积 
F_wind = 0.625*S_wind*v_wind^2;%风力
theta1 = atan((F0-G0)/F_wind);%钢管1的水平夹角
T1 = sqrt((F0-G0)^2+(F_wind)^2);%钢管1的张力
T(1) = T1; theta(1) = theta1;

%钢管受力分析
for i = 1:4
    m(i) = 10;%钢管质量 kg
    G(i) = m(i)*g;%钢管重力
    l(i) = 1;%钢管长度 m
    d(i) = 50/1000;%钢管直径 m
    F(i) = rho*g*pi*(d(i)/2)^2*l(i);%钢管浮力
    
    T(i+1) = (  (F(i)-G(i)+T(i)*sin(theta(i)))^2  +...
        (T(i)*cos(theta(i)))^2    )^(1/2);
    theta(i+1) = atan(  (  (F(i)-G(i)+T(i)*sin(theta(i)))/...
        (T(i)*cos(theta(i)) ))   );
    
    %钢管i的坐标（xi,yi）
    y(i+1) = y(i) - l(i)*sin(theta(i));
    x(i+1) = x(i) - l(i)*cos(theta(i));
end

%钢桶受力分析
m_tong = 100;%钢桶的质量 kg
G_tong = m_tong*g;%钢桶重力
% m_qiu = 1200;%重物球质量 kg
G_qiu = m_qiu*g;%重物球重力
l_tong = 1;%钢桶长 m
D_tong = 30/100;%钢桶底长
F_tong = rho*g*pi*(D_tong/2)^2*l_tong;%钢桶浮力

T_tong = ( (F_tong-G_tong-G_qiu+T(5)*sin(theta(5)))^2 + ...
                (T(5)*cos(theta(5)))^2)^(1/2);
theta_tong = atan( ((F_tong-G_tong-G_qiu+T(5)*sin(theta(5)))...
                      /(T(5)*cos(theta(5)))) );
T(6) = T_tong;
theta(6) = theta_tong;

y(6) = y(5) - l_tong*sin(theta(5));
x(6) = x(5) - l_tong*cos(theta(5)); 

%锚链线分析
G_mao = II*m_II*g;%单位长度重量
L_tuo = 0;%锚链拖尾长度
for i = 6 : 6+n-1
    if  theta(i) - 0 > 0.001
        T(i+1) = T(i) - G_mao*sin(theta(i));
        theta(i+1) = theta(i) - (G_mao*cos(theta(i)))/(T(i)-G_mao*sin(theta(i))); 
        y(i+1) = y(i) - sin(theta(i))*II;
        x(i+1) = x(i) - cos(theta(i))*II; 
    else 
        T(i+1) = 0;
        theta(i+1) = 0;
        y(i+1) = y(i);
        x(i+1) = x(i) - II;
        L_tuo = L_tuo+II;
    end
end

%构建输出[y, x, theta, T, stat]
if nargout == 5
    y = y;
    x = x;
    theta = theta;
    T= T; 
    % stat：要求的系泊系统参数，包括：吃水深度h、横坐标x0、游动区域S、钢桶竖直夹角alpha1、锚链底端水平夹角alpha2、风速v_wind、重物球质量m、系统状态yxthetaT
    stat.h = abs(y0);
    stat.y0 = y0;
    stat.x0 = x0;
    stat.yn = y(end);
    stat.xn = x(end);
    stat.S = pi*x0^2;
    stat.alpha1 = 90 - 90*theta(5)/pi*2;%角度制
    stat.alpha2 = 90*theta(end-1)/pi*2;%角度制
    stat.v_wind = v_wind;
    stat.m_qiu = m_qiu;
    stat.L_tuo = L_tuo;
    stat.x = x;
    stat.y = y;
    stat.theta  =theta;
    stat.T = T;
end
if xitong_figure == 1
    figure
    %系统曲线
    plot(x(6:end), y(6:end), '-', 'color', rand(1, 3))
    hold on
    plot(x(1:5), y(1:5), '-*y', 'LineWidth', 2)
    plot(x(5:6), y(5:6), '-r', 'LineWidth', 12)
    %浮漂
    box_biao = [x0 - D/2, y0; x0+D/2, y0; x0+D/2, y0+h0; x0-D/2, y0+h0];
    fill(box_biao(:, 1), box_biao(:, 2), 'b');
    %重物球
    plot([x(6), x(6)], [y(6), y(6)-1.5], '-')
    A = linspace(0, 2*pi, 100);
    qiu_r = 0.25;%重物球半径
    qiu_x = x(6)+qiu_r*sin(A);
    qiu_y = (y(6)-1.5)+qiu_r*cos(A);
    fill(qiu_x, qiu_y, 'k');
    %锚
    box_mao = [x(end), y(end); x(end)-1, y(end); x(end)-1, y(end)+1;
        x(end), y(end)+1];
    fill(box_mao(:, 1), box_mao(:, 2), 'k');
    %注释
    alpha1 = 90 - 90*theta(5)/pi*2;%角度制
    alpha2 = 90*theta(end-1)/pi*2;%角度制
    text(x0-2, y0-1, [num2str(x0),',',num2str(y0)])
    text(x(6)-3, y(6)-2, ['重物球质量:', num2str(m_qiu)])
    text(x(6)-0.5, y(6), ['钢桶倾角:', num2str(alpha1)])
    text(x(end)+0.5, y(end)+1.5, ['锚链夹角:', num2str(alpha2)])
    if L_tuo ~= 0
        text(x(end)+0.5, y(end)+0.5, ['拖尾长度:', num2str(L_tuo)])
    end
    %图形修饰
%     box off
    axis equal
    xlabel('风力方向')
    ylabel('竖直方向')
    title(['风速',num2str(v_wind),'、吃水深度', num2str(abs(y0)), '时的系泊系统'])
    hold off
end
    
end








