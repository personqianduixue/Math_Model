function [ ret ] = gen_passenger()
% 计算乘客位置参数
% xmax = 111*cos(pi*34/180)*1.4 = 129
% ymax = 0.7*111 = 78

xmax = 111*cos(pi*34/180)*1.4/10;
ymax = 0.7*111/10;
ux = xmax/2;uy = ymax/2;
sigmax = xmax/2/3;sigmay = ymax/2/3;
    th = 6.5/((pi/2)^0.5);
    while(1)
        xs = normrnd(ux,sigmax);%出发点横坐标
        ys = normrnd(uy,sigmay);%出发点纵坐标
        if xs<0 || xs>xmax || ys<0 || ys > ymax
            continue
        end
        d_go = sqrt(-2*th^2*log(1-rand()))/10;%出行距离
        degree = 2*pi*rand();%出行角度
        xd = xs + d_go.*cos(degree);
        yd = ys + d_go.*sin(degree);
        if(xd>=0 && xd<=xmax && yd>=0 && yd<=ymax)
            ret = [xs,ys,xd,yd,d_go];
            break
        end

    end
end

