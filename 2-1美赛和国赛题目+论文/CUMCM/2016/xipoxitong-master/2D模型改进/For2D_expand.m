function f = For2D_expand(xx, H, v1, v2, m_qiu, I, L, xitong_figure, xitong_save)
%此函数是系泊系统的3元方程组的目标函数,用于fsolve函数。模型改进：引入"力矩平衡"和"悬链线方程"
%
%%%%输入%%%%
% xx：y0,x0,alpha2。
% v1：风速。
% v2：水速。
% H：海水深度。
% m_qiu：重物球质量。
% I：锚链型号。1、2、3、4、5
% L：锚链长度。
% xitong_figure：是否输入系统图像
% xitong_save：是否保存系统数值结果


%%%%正文%%%%
y0 = xx(1);
x0 = xx(2);
alpha2 = xx(3);

h = H - y0;
y(1) = y0;
x(1) = x0;

%浮标受力
rho = 1.025*10^3;%海水的密度  kg/m^3
g = 9.8;%重力加速度 N/kg
D = 2;%圆柱浮标地面直径 m
h0 = 2;%圆柱浮标高度 m
m0= 1000;%浮标质量 kg
F0 = rho*g*pi*(D/2)^2*h;%浮标浮力
G0 = m0*g;%浮标重力
% v1 = 24;%风速 m/s
% v2 = 1.5;%水速 m/s

S_wind = D*(h0 - h);%风受力面积 
Fw = 0.625*S_wind*v1^2;%风力
Fs0 = 374*D*h*v2^2;%海水流力

Tx(1) = Fw + Fs0;
Ty(1) = F0 - G0;

%钢管受力
for i = 1:4
    l(i) = 1;%钢管长度 m
    d(i) = 50/1000;%钢管直径 m
    m(i) = 10;%钢管质量 kg
    G(i) = m(i)*g;%钢管重力
    F(i) = rho*g*pi*(d(i)/2)^2*l(i);%钢管浮力

    %%%%参考：http://blog.sina.com.cn/s/blog_53f291190100cjss.html
    si = @(theta1)d(i)*(pi/2*d(i)*cos(theta1) + l(i)*sin(theta1));%第一根钢管的海水法平面投影
    Fsi = @(theta1)374*si(theta1)*v2^2;%第一根钢管的海水力

    fun = @(theta1)(G(i) - F(i))/2*cos(theta1) + Tx(i)*sin(theta1) + Fsi(theta1)*sin(theta1)/2 - Ty(i)*cos(theta1);
    theta1 = fsolve(fun, 0);
    theta(i) = theta1;
    
    Tx(i+1) = Tx(i) + Fsi(theta(i));
    Ty(i+1) = Ty(i) + F(i) - G(i);
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

si = @(theta1)D_tong*(pi/2*D_tong*cos(theta1) + l_tong*sin(theta1));%第一根钢管的海水法平面投影
Fsi = @(theta1)374*si(theta1)*v2^2;%第一根钢管的海水力

fun = @(theta1)(G_tong - F_tong)/2*cos(theta1) + Tx(5)*sin(theta1) + Fsi(theta1)*sin(theta1)/2 - Ty(5)*cos(theta1);
theta_tong = fsolve(fun, 0);
theta(5) = theta_tong;

Tx(6) = Tx(5) + Fsi(theta(5));
Ty(6) = Ty(5) + F_tong - G_tong - G_qiu;
y(6) = y(5) - l_tong*sin(theta(5));
x(6) = x(5) - l_tong*cos(theta(5)); 

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
n = floor(L/II);
% L = 22.05;
w = m_II*g;
% if alpha2 == 0 & Ty(6) <= n*w
%     
%     f(1) = Tx(6)/w*cosh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*sec(alpha2)...
%         - y0 + l(1)*sin(theta(1)) + l(2)*sin(theta(2)) + l(3)*sin(theta(3)) + l(4)*sin(theta(4))...
%          + l_tong*sin(theta(5));   
%     f(2) = Tx(6)/w*sinh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*tan(alpha2)...
%         - L;
%     f(3) = Ty(6)/Tx(6) - sinh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2)));
% else
%   
% end
f(1) = Tx(6)/w*cosh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*sec(alpha2)...
    - y0 + l(1)*sin(theta(1)) + l(2)*sin(theta(2)) + l(3)*sin(theta(3)) + l(4)*sin(theta(4))...
     + l_tong*sin(theta(5));
f(2) = Tx(6)/w*sinh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*tan(alpha2)...
    - L;
% f(3) = (Ty(6) - n*w)/Tx(6);
% f(3) = Ty(6)*cosh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2))) - sqrt((Tx(6))^2 + (Ty(6))^2);
f(3) = Ty(6)/Tx(6) - sinh(w/Tx(6)*x(6) + log(tan(alpha2) + sec(alpha2)));  

%输出结果：系统图像和数值结果
if xitong_figure == 1
    %1、绘制系统图像
    figure
    %系统曲线
    Y = @(X)Tx(6)/w*cosh(w/Tx(6)*X + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*sec(alpha2);
    X = linspace(x(6)-0.5, 0, 200);
    x = [x, X];
    y = [y, Y(X)];
    %矫正alpha2。if alpha2 < 0 then ......
    alpha2 = 90*alpha2/pi*2;%角度制
    if alpha2 < 0
        Ydao = @(X)sinh(w/Tx(6)*X + log(tan(alpha2) + sec(alpha2)));
        L_tuo = fzero(Ydao, [0+0.3, x0]);
        y(y<0) = 0;
    else
        L_tuo = 0;
    end
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
    title(['风速',num2str(v1),'、吃水深度', num2str(abs(H-y0)), '时的系泊系统'])
    hold off
end

if xitong_save == 1 
    %2、保存数值结果
    Y = @(X)Tx(6)/w*cosh(w/Tx(6)*X + log(tan(alpha2) + sec(alpha2))) - Tx(6)/w*sec(alpha2);
    X = linspace(x(6)-0.5, 0, 200);
    x = [x, X];
    y = [y, Y(X)];
    %矫正alpha2。if alpha2 < 0 then ......
    alpha2 = 90*alpha2/pi*2;%角度制
    if alpha2 < 0
        L_tuo = fzero(Y, [0+0.3, x0]);
        y(y<0) = 0;
    else
        L_tuo = 0;
    end
    
    stat.h = abs(y0);
    stat.y0 = y0;
    stat.x0 = x0;
    stat.yn = y(end);
    stat.xn = x(end);
    stat.S = pi*x0^2;
    stat.alpha1 = 90 - 90*theta(5)/pi*2;%角度制
    stat.alpha2 = alpha2;%角度制
    stat.H = H;
    stat.v1 = v1;
    stat.v2 = v2;
    stat.m_qiu = m_qiu;
    stat.L = L;
    stat.L_tuo = L_tuo;
    stat.x = x;
    stat.y = y;
    stat.theta = theta;
    FILENAME = '系统信息.mat';
    save(FILENAME, 'stat')
end

end















