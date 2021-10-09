clc, clear
A=imread('tu5.bmp'); %读入载体文件
W=imread('tu6.bmp');  %读入水印文件
[m1,m2,m3]=size(W);  %给出矩阵W的维数
A0=A([1:m1],[1:m2],:); %在矩阵A的左上角选取与W同样大小的子块
A0=double(A0); W=double(W); %进行数据类型转换
a=0.05; %嵌入强度因子为0.05
for i=1:3
    [U1{i},S1{i},V1{i}]=svd(A0(:,:,i)); %对载体R，G，B层分别进行奇异值分解
    A1(:,:,i)=S1{i}+a*W(:,:,i);  %计算A1矩阵
    [U2{i},S2{i},V2{i}]=svd(A1(:,:,i)); %对A1的各层进行奇异值分解
    A2(:,:,i)=U1{i}*S2{i}*V1{i}'; %计算A2矩阵
end
AW=A;  %整体水印合成图片初始化
AW([1:m1],[1:m2],:)=A2; %左上角替换成水印合成子块，水印嵌入完成
AW=uint8(AW); W=uint8(W); %变换回原来的数据类型
subplot(1,3,1), imshow(A) %显示载体图片
subplot(1,3,2), imshow(W) %显示水印图片
subplot(1,3,3), imshow(AW) %显示嵌入水印的合成图片
%以下是水印的提出
AWstar=imnoise(AW,'gaussian',0,0.01); %加入高斯噪声
A2star=AWstar([1:m1],[1:m2],:);  %提出子块
A2star=double(A2star); %进行数据类型转换
for i=1:3
    [U3{i},S2star{i},V3{i}]=svd(A2star(:,:,i)); %奇异值分解
    A1star(:,:,i)=U2{i}*S2star{i}*V2{i}';  %计算A1*
    Wstar(:,:,i)=(A1star(:,:,i)-S1{i})/a;  %计算W*
end
for i=1:3
Wstar(:,:,i)=medfilt2(Wstar(:,:,i));  %对提取水印的R,G,B层分别进行中值滤波
end
Wstar=uint8(Wstar); %进行类型转换
figure, subplot(1,2,1), imshow(AWstar) %显示被噪声污染的合成图片
subplot(1,2,2), imshow(Wstar) %显示提出的水印图片
