close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load woman;         %读取图像数据
nbcol=size(map,1);
[c,s]=wavedec2(X,2,'db2');%采用db4小波进行2层图像分解
siz=s(size(s,1),:);       %获取原图像矩阵X的大小
ca2=appcoef2(c,s,'db2',2);%提取多层小波分解结构C和S的第1层小波变换的近似系数
chd2=detcoef2('h',c,s,2); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的水平分量
cvd2=detcoef2('v',c,s,2); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的垂直分量
cdd2=detcoef2('d',c,s,2); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的对角分量
chd1=detcoef2('h',c,s,1); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的水平分量
cvd1=detcoef2('v',c,s,1); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的垂直分量
cdd1=detcoef2('d',c,s,1); %利用的多层小波分解结构C和S来提取图像第1层的细节系数的对角分量
ca11=ca2+chd2+cvd2+cdd2;  %叠加重构近似图像          
ca1 = appcoef2(c,s,'db4',1);%提取多层小波分解结构C和S的第1层小波变换的近似系数
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])%修改图形背景颜色的设置
figure                                             %显示图像结果
subplot(1,4,1); imshow(uint8(wcodemat(ca2,nbcol)));
subplot(1,4,2); imshow(uint8(wcodemat(chd2,nbcol)));
subplot(1,4,3); imshow(uint8(wcodemat(cvd2,nbcol)));
subplot(1,4,4); imshow(uint8(wcodemat(cdd2,nbcol)));
figure
subplot(1,4,1); imshow(uint8(wcodemat(ca11,nbcol)));
subplot(1,4,2); imshow(uint8(wcodemat(chd1,nbcol)));
subplot(1,4,3); imshow(uint8(wcodemat(cvd1,nbcol)));
subplot(1,4,4); imshow(uint8(wcodemat(cdd1,nbcol)));
disp('小波二层分解的近似系数矩阵ca2的大小：')  %显示小波分解系数矩阵的大小
ca2_size=s(1,:)
disp('小波二层分解的细节系数矩阵cd2的大小:')
cd2_size=s(2,:)
disp('小波一层分解的细节系数矩阵cd1的大小:')
cd1_size=s(3,:)
disp('原图像大小:')
X_size=s(4,:)
disp('小波分解系数分量矩阵c的长度:')
c_size=length(c)