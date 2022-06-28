%【例11-17】
close all;							%关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc
I=imread('cameraman.tif');              %读入要处理的图像，并赋值给I
%set(0,'defaultFigurePosition',[100,100,1000,500]);	%修改图形图像位置的默认设置
%set(0,'defaultFigureColor',[1 1 1])
Image=I;                              %图像I数据赋给Image
figure;subplot(121);imshow(Image); 
Image1=imrotate(I,10,'bilinear');         %图像顺时针旋转10度--旋转变换
subplot(122);imshow(Image1);
Image2=fliplr(I);                       %对图像做镜像变换---镜像变换  
figure;subplot(121);imshow(Image2);
Image3=imresize(I,0.3,'bilinear');        %图像缩小1/3---尺寸变换
subplot(122);imshow(Image3);
%调用自定义函数Moment_Seven()求解图像七阶矩%
display('原图像');
Moment_Seven(Image);
display('旋转变化后的图像');
Moment_Seven(Image1);
display('镜像变化后的图像');
Moment_Seven(Image2);
display('尺度变化后的图像');
Moment_Seven(Image3);
%求7阶矩函数Moment_Seven()的函数清单：
function Moment_Seven(J)                  %J为要求解的图像
A=double(J);                               %将图像数据转换为double类型
[m,n]=size(A);                              %求矩阵A的大小
[x,y]=meshgrid(1:n,1:m);                     %生成网格采样点的数据，x,y的行数等于m，列数等于n
x=x(:);                                     %矩阵赋值    
y=y(:);                                           
A=A(:);                                     
m00=sum(A);                               %求矩阵A中每列的和，得到m00是行向量
if m00==0                                  %如果m00=0，则赋值m00=eps，即m00=0
    m00=eps;
end
m10=sum(x.*A);                             %以下为7阶矩求解过程，参见7阶矩的公式
m01=sum(y.*A);
xmean=m10/m00;
ymean=m01/m00;
cm00=m00;
cm02=(sum((y-ymean).^2.*A))/(m00^2);
cm03=(sum((y-ymean).^3.*A))/(m00^2.5);
cm11=(sum((x-xmean).*(y-ymean).*A))/(m00^2);
cm12=(sum((x-xmean).*(y-ymean).^2.*A))/(m00^2.5);
cm20=(sum((x-xmean).^2.*A))/(m00^2);
cm21=(sum((x-xmean).^2.*(y-ymean).*A))/(m00^2.5);
cm30=(sum((x-xmean).^3.*A))/(m00^2.5);
Mon(1)=cm20+cm02;                        %1阶矩Mon(1)
Mon(2)=(cm20-cm02)^2+4*cm11^2;           %2阶矩Mon(2)
Mon(3)=(cm30-3*cm12)^2+(3*cm21-cm03)^2;  %3阶矩Mon(3)
Mon(4)=(cm30+cm12)^2+(cm21+cm03)^2;     %4阶矩Mon(4)
Mon(5)=(cm30-3*cm12)*(cm30+cm12)*((cm30+cm12)^2-3*(cm21+cm03)^2)+(3*(cm30+cm12)^2-(cm21+cm03)^2);                                        %5阶矩Mon(5)
Mon(6)=(cm20-cm02)*((cm30+cm12)^2-(cm21+cm03)^2)+4*cm11*(cm30+cm12)*(cm21+cm03); %6阶矩Mon(6)
Mon(7)=(3*cm21-cm03)*(cm30+cm12)*((cm30+cm12)^2-3*(cm21+cm03)^2)+(3*cm12-cm30)*(cm21+cm03)*(3*(cm30+cm12)^2-(cm21+cm03)^2);             %7阶矩Mon(7)
Moment=abs(log(Mon))                      %采用log函数缩小不变矩的动态范围值
