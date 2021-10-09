function [ ret ] = gen_taxi( input_args )
% 计算出租车位置参数
%   Detailed explanation goes here
    xmax = 111*cos(pi*34/180)*1.4/10;
    ymax = 0.7*111/10;
    ux = xmax/2;uy = ymax/2;
    sigmax = xmax/2/3;sigmay = ymax/2/3;
    while(1)
        x = normrnd(ux,sigmax);%出发点横坐标
        y = normrnd(uy,sigmay);%出发点纵坐标
        if x>=0 && x<=xmax && y>=0 && y <= ymax
            break
        end    
    end
    ret = [x,y,0];
end

