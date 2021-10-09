%garborfilter()定义，I为输入图像；Sx、Sy是变量在x、y轴变化的范围，即选定的gabor小波窗口的大小；f为
%正弦函数的频率；theta为gabor滤波器的方向。G为gabor滤波函数g(x,y)；gabout为gabor滤波后的图像。
%二维gabor滤波函数:
%                            -1     xp ^     yp  ^             
%%% G(x,y,theta,f) =  exp ([----{(----) 2+(----) 2}])*cos(2*pi*f*xp);
%                             2    Sx      Sy
%%% xp = x*cos(theta)+y*sin(theta);
%%% yp = y*cos(theta)-x*sin(theta);

function [G,gabout] = gaborfilter(I,Sx,Sy,f,theta);     
if isa(I,'double')~=1                                      %判断输入图像数据是否为double类型。
    I = double(I);                                        %若不是将I变为double类型
end
for x = -fix(Sx):fix(Sx)                                    %选定窗口大小
    for y = -fix(Sy):fix(Sy)                                %求G
        xp = x * cos(theta) + y * sin(theta);
        yp = y * cos(theta) - x * sin(theta);
        G(fix(Sx)+x+1,fix(Sy)+y+1) = exp(-.5*((xp/Sx)^2+(yp/Sy)^2))*cos(2*pi*f*xp);
    end
end
Imgabout = conv2(I,double(imag(G)),'same');               %对图像虚部做二维卷积
Regabout = conv2(I,double(real(G)),'same');                %对图像数据实部做二维卷积
gabout = sqrt(Imgabout.*Imgabout + Regabout.*Regabout);  %gabor小波变换后的图像gabout 
