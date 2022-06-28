function [BW,runningt]=Denoise(RGB,M)
 %RGB原图像，M表示叠加噪声的次数；BW为消除噪声的图像，runningt为函数运行时间

A=imnoise(RGB,'gaussian',0,0.05);   %加入高斯白噪声
I=A;                                %将A赋值给I
I=im2double(I);                     %将I数据类型转换成双精度
RGB=im2double(RGB);                     
tstart=tic; %开始计时
for i=1:M
   I=imadd(I,RGB);                  %对用原图像与带噪声图像进行多次叠加，结果返回给I
end
avg_A=I/(M+1);                      %求叠加的平均图像 
runningt=toc(tstart);               %计时结束
BW=avg_A;