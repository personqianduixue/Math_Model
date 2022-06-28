function BW=refine_face_detection(I)
% I是待识别的彩色图像，BW是检测到二值人脸图像
%%肤色聚类
I1=I;             %输入图像矩阵I
R=I1(:,:,1);      %获取RGB图像矩阵I的R、G、B取值
G=I1(:,:,2);
B=I1(:,:,3);
Y=0.299*R+0.587*G+0.114*B; %进行颜色空间转换 计算Y 和Cb
Cb=-0.1687*R-0.3313*G+0.5000*B+128;
for Cb=133:165
    r=(Cb-128)*1.402+Y;  %将YCrCb空间中Cb=133:165中的区域确定
    r1=find(R==r);       %产生肤色聚类的二值矩阵
    R(r1)=255;           %对肤色聚类的区域
    G(r1)=255;
    B(r1)=255;
end
I1(:,:,1)=R;            %生成肤色聚类后的图像
I1(:,:,2)=G;
I1(:,:,3)=B;
J=im2bw(I1,0.99);       %转换成灰度图像
%% 膨胀和腐蚀
SE1=strel('square',8);
BW1=imdilate(J,SE1);%先小面积膨胀
BW1=imfill(BW1,'holes');%填充区域里的洞
SE1=strel('square',20);
BW1=imerode(BW1,SE1);%大面积的腐蚀
SE1=strel('square',12);
BW1=imdilate(BW1,SE1);%膨胀，恢复人脸区域
%% 定位人脸的大致区域
[B,L,N]=bwboundaries(BW1,'noholes');%边界跟踪
a=zeros(1,N);
for i1=1:N
    a(i1)=length(find(L==i1)); %获取斑点位置
end
a1=find(a==max(a));
L1=(abs(L-a1))*255;  
I2=double(rgb2gray(I)); %原彩色图像转灰度图像
I3=uint8(I2-L1);        %消除斑点
BW=I3;                   %返回结果