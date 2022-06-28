close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
load woman;               %读取图像数据
[c,s]=wavedec2(X,2,'db2');%采用db4小波进行2层图像分解
nbcol=size(map,1);
s1=s(1,:);                %获取小波分解系数矩阵大小
s2=s(3,:);
ca2=zeros(s1);            %初始化分解系数矩阵
chd2=zeros(s1);
cvd2=zeros(s1);
cdd2=zeros(s1);
chd1=zeros(s2);
cvd1=zeros(s2);
cdd1=zeros(s2);
l1=s1(1)*s1(1);
l2=s2(1)*s2(1);
%从分解系数矩阵C和长度矩阵S中提取细节
ca2=reshape(c(1:l1),s1(1),s1(1));%提取第2层小波变换的近似系数
chd2=reshape(c(l1+1:2*l1),s1(1),s1(1));%提取图像第2层的细节系数的水平分量
cvd2=reshape(c(2*l1+1:3*l1),s1(1),s1(1));%提取图像第2层的细节系数的垂直分量
cdd2=reshape(c(3*l1+1:4*l1),s1(1),s1(1));%提取图像第2层的细节系数的对角分量
chd1=reshape(c(4*l1+1:4*l1+l2),s2(1),s2(1));%提取图像第1层的细节系数的水平分量
cvd1=reshape(c(4*l1+l2+1:4*l1+2*l2),s2(1),s2(1));%提取图像第1层的细节系数的垂直分量
cdd1=reshape(c(4*l1+2*l2+1:4*l1+3*l2),s2(1),s2(1));%提取图像第1层的细节系数的对角分量
%利用函数appcoef2()和detcoef2()提取小波分解系数
ca2_1=appcoef2(c,s,'db2',2);%提取第2层小波变换的近似系数
chd2_1=detcoef2('h',c,s,2); %提取图像第2层的细节系数的水平分量
cvd2_1=detcoef2('v',c,s,2); %提取图像第2层的细节系数的垂直分量
cdd2_1=detcoef2('d',c,s,2); %提取图像第2层的细节系数的对角分量
chd1_1=detcoef2('h',c,s,1); %提取图像第1层的细节系数的水平分量
cvd1_1=detcoef2('v',c,s,1); %提取图像第1层的细节系数的垂直分量
cdd1_1=detcoef2('d',c,s,1); %提取图像第1层的细节系数的对角分量
disp('比较两种方法获取小波分解系数是否相同：')
disp(' ')
if isequal(ca2,ca2_1)
    disp('      ca2和ca2_1相同')
    disp(' ')
end
if isequal(chd2,chd2_1)
    disp('      chd2和chd2_1相同')
    disp(' ')
end    
if isequal(cvd2,cvd2_1)
    disp('      cvd2和cvd2_1相同')
    disp(' ')
end
if isequal(cdd2,cdd2_1)
    disp('      cdd2和cdd2_1相同')
    disp(' ')
end    
if isequal(chd1,chd1_1)
    disp('      chd1和chd1_1相同')
    disp(' ')
end   
if isequal(cvd1,cvd1_1)
    disp('      cvd1和cvd1_1相同')
    disp(' ')
end  
if isequal(cdd1,cdd1_1)
    disp('      cdd1和cdd1_1相同')
    disp(' ')
end   