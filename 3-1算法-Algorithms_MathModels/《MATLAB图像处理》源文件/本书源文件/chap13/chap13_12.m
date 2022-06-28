close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
X=imread('6.bmp');                          %把原图象转化为灰度图像，装载并显示
X=double(rgb2gray(X)); 
init=2055615866;%生成含噪图象并显示
randn('seed',init)
X1=X+25*randn(size(X));%生成含噪图像并显示
[thr,sorh,keepapp]=ddencmp('den','wv',X1);%消噪处理：设置函数wpdencmp的消噪参数
X2=wdencmp('gbl',X1,'sym4',2,thr,sorh,keepapp);
X3=X;                                   %保存纯净的原图像
for i=2:577;
      for j=2:579
           Xtemp=0;
            for m=1:3
                 for n=1:3
                       Xtemp=Xtemp+X1((i+m)-2,(j+n)-2);%对图像进行平滑处理以增强消噪效果（中值滤波）
                end      
            end
            Xtemp=Xtemp/9;
            X3(i-1,j-1)=Xtemp;
      end    
end
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])       %修改图形背景颜色的设置
figure
subplot(121);imshow(uint8(X)); axis square;              %画出原图象
subplot(122);imshow(uint8(X1));axis square;              %画出含噪声图象
figure
subplot(121),imshow(uint8(X2)),axis square;%画出消噪后的图像
subplot(122),imshow(uint8(X3)),axis square;%显示结果
Ps=sum(sum((X-mean(mean(X))).^2));%计算信噪比
Pn=sum(sum((X1-X).^2));
Pn1=sum(sum((X2-X).^2));
Pn2=sum(sum((X3-X).^2));
disp('未处理的含噪声图像信噪比')
snr=10*log10(Ps/Pn)
disp('采用小波全局阈值滤波的去噪图像信噪比')
snr1=10*log10(Ps/Pn1)
disp('采用中值滤波的去噪图像信噪比')
snr2=10*log10(Ps/Pn2)