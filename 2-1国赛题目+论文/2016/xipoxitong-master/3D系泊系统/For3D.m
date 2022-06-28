function [z, y, x, theta, alpha, T, stat] = For3D(z0, y0, x0, v1, v2, m_qiu, I, L, beta, xitong_figure)
% 此函数用于给定x0、y0和z0后求解3D系泊系统的状态曲线
%
%%%%输入%%%%
% z0：浮标z轴坐标，|z0|=h。其中，h为吃水深度。
% y0：浮标纵坐标。
% x0：浮标横坐标。
% v1：风速。
% v2：水速。
% m_qiu：重物球质量。
% I：锚链型号。1、2、3、4、5
% L：锚链长度。
% beta：风力与水力的夹角。
% xitongfigure：是否输出系统图像。logistic
%
%%%%输出%%%%
% z：系泊系统z轴坐标。
% y：系泊系统纵坐标。向量
% x：系泊系统横坐标。
% theta：系泊系统水平面夹角。
% alpha：系泊系统x轴正方向夹角。
% T：系泊系统拉力。
% stat：要求的系泊系统参数，包括：吃水深度h、横坐标x0、游动区域S、钢桶竖直夹角alpha1、锚链底端水平夹角alpha2、风速v_wind、重物球质量m、系统状态yxthetaT。stats

%默认输入
if nargin < 10
    xitong_figure = 0;
end
if nargin < 9
    beta = pi/2;
end
if nargin < 8
    L = 22.05;%锚链长度 m
end
if nargin < 7
    I = 2;
end
if nargin < 6
    m_qiu = 500;
end
if nargin < 5
    v2 = 1.5;
end
if nargin < 4
    v1 = 12;
end
if nargin < 3
    x0 = -5;
end
if nargin < 2
    y0 = 20;
end
if nargin < 1
    disp('请输入参数')
    return;
end

%%%%正文%%%%
h = abs(z0);
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

%浮标、钢管分析
fun = @(x_point)(D3fun_fubiao(x_point, beta, z0, v1, v2));
X0 = [14000, 0, pi/2];%T1、theta1和alpha1的初始搜索点
[x_solve, ~] = fsolve(fun, X0);

T(1) = x_solve(1);
theta(1) = x_solve(2);
alpha(1) = x_solve(3);
x(1) = x0;
y(1) = y0;
z(1) = z0;

for i = 1:4
    l = 1;%钢管长度
    
    Ti = T(i);
    thetai = theta(i);
    alphai = alpha(i);
    fun = @(x_point)(D3fun_gangguan(x_point, Ti, thetai, alphai, beta, v2));
    X0 = [Ti, thetai, alphai];%T、theta和alpha的初始搜索点
    [x_solve, ~] = fsolve(fun, X0);
    
    T(i+1) = x_solve(1);
    theta(i+1) = x_solve(2);
    alpha(i+1) = x_solve(3);
    if alpha(i) < pi/2
        x(i+1) = x(i) + l*cos(theta(i))*cos(alpha(i));
    else
        x(i+1) = x(i) - l*cos(theta(i))*cos(alpha(i));
    end
    y(i+1) = y(i) - l*cos(theta(i))*sin(alpha(i));
    z(i+1) = z(i) - l*sin(theta(i));
end

%钢桶分析
l_tong = 1;%钢桶长 m
T5 = T(5);
theta5 = theta(5);
alpha5 = alpha(5);
fun = @(x_point)(D3fun_gangtong(x_point, T5, theta5, alpha5, beta, v2, m_qiu));
X0 = [T5, theta5, alpha5];
[x_solve, ~] = fsolve(fun, X0);

T(6) = x_solve(1);
theta(6) = x_solve(2);
alpha(6) = x_solve(3);
if alpha(5) < pi/2
    x(6) = x(5) + l_tong*cos(theta(5))*cos(alpha(5));
else
    x(6) = x(5) - l_tong*cos(theta(5))*cos(alpha(5));
end
y(6) = y(5) - l_tong*cos(theta(5))*sin(alpha(5));
z(6) = z(5) - l_tong*sin(theta(5));

%锚链线分析
L_tuo = 0;%锚链拖尾长度
for i = 6 : 6+n-1
    if  theta(i) - 0 >0.001
        Ti = T(i);
        thetai = theta(i);
        alphai = alpha(i);
        fun = @(x_point)(D3fun_maolian(x_point, Ti, thetai, alphai, I));
        X0 = [Ti, thetai, alphai];%T、theta和alpha的初始搜索点
        [x_solve, ~] = fsolve(fun, X0);

        T(i+1) = x_solve(1);
        theta(i+1) = x_solve(2);
        alpha(i+1) = x_solve(3);
        if alpha(i) < pi/2
            x(i+1) = x(i) + II*cos(theta(i))*cos(alpha(i));
        else
            x(i+1) = x(i) - II*cos(theta(i))*cos(alpha(i));
        end
        y(i+1) = y(i) - II*cos(theta(i))*sin(alpha(i));
        z(i+1) = z(i) - II*sin(theta(i));
    else 
        T(i+1) = 0;
        theta(i+1) = 0;
        alpha(i+1) = alpha(i);
        
        z(i+1) = z(i);
        y(i+1) = y(i) - II*sin(alpha(i));
        if alpha(i) < pi/2
            x(i+1) = x(i) + II*cos(alpha(i));
        else
            x(i+1) = x(i) - II*cos(alpha(i));
        end
        L_tuo = L_tuo+II;
    end
end


%构建输出[z, y, x, theta, alpha, T, stat]
if nargout == 7
    z = z;
    y = y;
    x = x;
    theta = theta;
    alpha = alpha;
    T= T; 
    % stat：要求的系泊系统参数，包括：吃水深度h、横坐标x0、游动区域S、钢桶竖直夹角alpha1、锚链底端水平夹角alpha2、风速v_wind、重物球质量m、系统状态yxthetaT
    stat.h = abs(z0);
    stat.z0 = z0;
    stat.y0 = y0;
    stat.x0 = x0;
    stat.zn = z(end);
    stat.yn = y(end);
    stat.xn = x(end);
    stat.S = pi*(x0^2 + y0^2);
    stat.alpha1 = 90 - 90*theta(5)/pi*2;%角度制
    stat.alpha2 = 90*theta(end-1)/pi*2;%角度制
    stat.v1 = v1;
    stat.v2 = v2;
    stat.m_qiu = m_qiu;
    stat.beta = beta;
    stat.L_tuo = L_tuo;
    stat.x = x;
    stat.y = y;
    stat.z = z;
    stat.theta = theta;
    stat.alpha = alpha;
    stat.T = T;
end

if xitong_figure == 1
    figure
    %系统曲线
    plot3(x(6:end), y(6:end), z(6:end), '-', 'color', rand(1, 3))
    hold on
    plot3(x(1:5), y(1:5), z(1:5), '-*y', 'LineWidth', 2)
    plot3(x(5:6), y(5:6), z(5:6), '-r', 'LineWidth', 12)
    
    %浮漂
    R = 1;%半径
    h0 = 2;%圆柱高度
    mm = 100;%分割线的条数
    [xx , yy, zz] = cylinder(R, mm);%创建以(0,0)为圆心，高度为[0,1]，半径为R的圆柱
    xx = xx + x0;%平移x轴
    yy = yy + y0;%平移y轴，改为(a,b)为底圆的圆心
    zz = h0*zz + z0;%平移z轴，高度放大h倍
    mesh(xx, yy, zz)%重新绘图
    
    fubiao_r = 1;%添加封顶数据
    t = linspace(0, pi, 25);
    p = linspace(0, 2*pi, 25);
    x1 = fubiao_r*cos(p) + x0;
    y1 = fubiao_r*sin(p) + y0;
    z1 = z0*ones(size(x1));
    fill3(x1, y1, z1, 'b')
    z2 = (h0 + z0)*ones(size(x1));
    fill3(x1, y1, z2, 'b')
    
    %重物球
    plot3([x(6), x(6)], [y(6), y(6)], [z(6), z(6)-1.5], '-')
    qiu_r = 0.25;
    [the, phi] = meshgrid(t, p);
    xxx = qiu_r*sin(the).*sin(phi);
    yyy = qiu_r*sin(the).*cos(phi);
    zzz = qiu_r*cos(the);
%     [xxx, yyy, zzz] = sphere;
    mesh(xxx + x(6), yyy + y(6), zzz + z(6)-1.5)%centered at (x6,y6,z6-1.5)
%     alpha(0.3)%控制图形的透明度，取值0~1 

    %锚
    boxplot3(x(end) - 0.5, y(end), z(end), 1, 1, 1)
    
    %注释
    alpha1 = 90 - 90*theta(5)/pi*2;%角度制
    alpha2 = 90*theta(end-1)/pi*2;%角度制
    text(x0, y0-2, z0-1, [num2str(x0),',',num2str(y0),',',num2str(z0)])
    text(x(6), y(6)-3, z(6)-2, ['重物球质量:', num2str(m_qiu)])
    text(x(6), y(6)-0.5, z(6), ['钢桶倾角:', num2str(alpha1)])
    text(x(end), y(end)+0.5, z(end)+1.5, ['锚链夹角:', num2str(alpha2)])
    if L_tuo ~= 0
        text(x(end), y(end)+0.5, z(end)+0.5, ['拖尾长度:', num2str(L_tuo)])
    end
    
    %图形修饰
%     box off
    view(3)%调整视角
    axis equal
    xlabel('x轴方向')
    ylabel('风力方向')
    zlabel('竖直方向')
    title(['风速',num2str(v1),'、吃水力度', num2str(abs(z0)), '时的系泊系统'])
    hold off
end


%%%%绘制圆柱体%%%%
% % Sample values
% h0 = 2; % height
% ra = 1; % radius
% % Create constant vectors
% tht = linspace(0, 2*pi, 100);
% z = linspace(0, h0, 20);
% % Create cylinder
% xa = repmat(ra*cos(tht),20,1); ya = repmat(ra*sin(tht),20,1);
% za = repmat(z',1,100);
% % To close the ends
% X = [xa*0; flipud(xa); (xa(1,:))*0]; 
% Y = [ya*0; flipud(ya); (ya(1,:))*0];
% Z = [za; flipud(za); za(1,:)];
% % Draw cylinder
% [TRI,v] = surf2patch(X,Y,Z,'triangle');
% patch('Vertices',v,'Faces',TRI,'facecolor',[0.5 0.8 0.8],'facealpha',0.8);
% view(3);
% grid on; 
% axis square; 
% title('Cylinder','FontSize',12)


end







