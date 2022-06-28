T = 0.1;
t = 0;
x = 0; y = 0;
x2 = 0; y2 = 0;

%Q = 6.4;
%Q = 6.505959742420578; %时间较优解
%Q = 6.50343622123985; %时间最优解
Q = 6.5044;%状态最为准确
%Q = 9.8769e-04;

sita = 0 + Q/180*pi;%23.17/180*pi;
vx = 1692;
vy = 0;

m0 = 2400;
m = 2400;
N = 7500 / m0;
G = 3844.6 / m0;
r = 1749372;
H = 15000;
ax = N - vy*vx/r;
ay = G - vx^2/r;

hold on
xlabel '切向距离/m'
ylabel '高度/m'
history = [];
i = 0;
while (y>-12000 && m>1000)
    x2 = x + vx*T - 0.5*ax*T;
    y2 = y - vy*T - 0.5*ay*T;
    vx = vx - ax*T; 
%     if vx < 0
%         vx = 0;
%     end;
    vy = vy + ay*T;
    
    r2 = 1749372 + y2;
    G = 3844.6/m0/(r^2)*(r2^2);
    m = m - 2.55*T;
    t = t + T;
    N = 7500 / m;
    if (vx == 0)
        if vy <= 0
            sita = pi/2;
        else
            sita = - pi / 2;
        end
    else
        sita = atan(vy/vx);
    end
    
    if (sita) <= 0
        sita = Q/180*pi;
    else
        if (sita + Q/180*pi) < pi/2
            sita = sita + Q/180*pi;
        else
            sita = pi / 2;
        end
    end
    
    ax = N * cos(sita) - vy*vx/r2;
    ay = G - N * sin(sita) - vx^2/r2;
    
    plot([x,x2],[H+y,H+y2],'black','LineWidth',2);
    x = x2; y = y2; r = r2;
    
    history = [history; (i-1)*T y vx vy sita];
    i = i + 1;
end