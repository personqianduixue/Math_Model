clc, clear 
a=imread('Lena.bmp'); %读入载体图像,图像的长和高都必须化成8的整数倍 
[M1,N1]=size(a); %计算载体图像的大小
a=im2double(a); %数据转换成double类型
knum1=M1/8; knum2=N1/8; %把载体图像划分成8×8的子块，高和长方向划分的块数
b0=imread('tu7.bmp'); %读入水印图像
b=im2double(b0); %数据转换成double类型
subplot(1,2,1), imshow(a)  %显示载体图像
subplot(1,2,2), imshow(b)  %显示水印图像
mask1=[1 1 1 1 0 0 0 0
       1 1 1 0 0 0 0 0
       1 1 0 0 0 0 0 0
       1 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0]; %给出低频的掩膜矩阵
ind1=find(mask1==1); %低频系数的位置
mask2=[0 0 0 0 1 1 0 0
       0 0 0 1 1 0 0 0
       0 0 1 1 0 0 0 0
       0 1 1 0 0 0 0 0
       1 1 0 0 0 0 0 0
       1 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0]; %给出中频的掩膜矩阵
ind2=find(mask2==1); %中频系数的位置，总共11个 
[M2,N2]=size(b); %计算水印图像的大小
L=M2*N2; %计算水印图像的像素个数
knum3=ceil(M2*N2/11); %水印图像按照11个元素1块，分的块数
b=b(:); b(L+1:11*knum3)=0; %水印图像数据变成列向量，后面不足一块的元素补0
T=dctmtx(8); %给出8×8的DCT变换矩阵 
ab=zeros(M1,N1); %合成图像的初始值 
k=0; %嵌入水印块计数器的初始值
for i=0:knum1-1  %该两层循环进行水印嵌入
    for j=0:knum2-1
        xa=a([8*i+1:8*i+8],[8*j+1:8*j+8]);  %提取载体图像的子块
        ya=T*xa*T';  %载体图像子块做DCT变换
        coef1=(mask1+mask2).*ya; %提取低频和中频系数，作为合成子块的初始值
        if k<knum3
        coef1(ind2)=coef1(ind2)+0.05*b(11*k+1:11*k+11); %在中频系数上嵌入水印子块的信息
        end
        ab([8*i+1:8*i+8],[8*j+1:8*j+8])=T'*coef1*T;%对合成子块进行逆DCT变换
        k=k+1;
    end
end
acha=ab-a; %提取合成图像和原图像的差图像；
k=0; tb=zeros(11*knum3,1); %提取水印图像的初始值
for i=0:knum1-1  %该两层循环进行水印提取
    for j=0:knum2-1
        xa2=acha([8*i+1:8*i+8],[8*j+1:8*j+8]);  %提取差图像的子块
        ya2=T*xa2*T';  %差图像子块做DCT变换
        coef2=mask2.*ya2; %提取差图像中频DCT系数
        if k<knum3
        tb(11*k+1:11*k+11)=20*coef2(ind2); %提取水印图像的像素值
        end
        k=k+1;
    end
end
tb(L+1:end)=[]; %把水印图像列向量的后面补的0删除
tb=reshape(tb,[M2,N2]); %把列向量变成矩阵
figure, subplot(1,2,1), imshow(ab) %显示水印合成图像
subplot(1,2,2), imshow(tb) %显示提取的水印图像
