%【例11-14】
I=imread('leaf1.bmp');                %读入图像数据赋值给I
I=rgb2gray(I);                        %将彩色图像变为灰度图像
bwI=im2bw(I,graythresh(I));            %对图像进行二值化处理得到二值化图像赋值给bwI
bwIsl=~bwI;                          %对二值图像取反
h=fspecial('average');                  %选择中值滤波        
bwIfilt=imfilter(bwIsl,h);                 %对图像进行中值滤波
bwIfiltfh=imfill(bwIfilt,'holes');            %填充二值图像的空洞区域
bdI=boundaries(bwIfiltfh,4,'cw');          %追踪4连接目标边界
d=cellfun('length',bdI);                   %求bdI中每一个目标边界的长度，返回值d是一个向量
[dmax,k]=max(d);                       %返回向量d中最大的值，存在max_d中，k为其索引
B4=bdI{k(1)};                           %若最大边界不止一条，则取出其中的一条即可。B4是一个坐标数组
[m,n]=size(bwIfiltfh);                     %求二值图像的大小
xmin=min(B4(:,1));                       
ymin=min(B4(:,2));    
%生成一幅二值图像,大小为m n，xmin,ymin是B4中最小的x和y轴坐标                   
bim=bound2im(B4,m,n,xmin,ymin);         
[x,y]=minperpoly(bwIfiltfh,2);               %使用大小为2的方形单元
b2=connectpoly(x,y);                     %按照坐标(X,Y)顺时针或者逆时针连接成多边形
B2=bound2im(b2,m,n,xmin,ymin);                     
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])      
figure,subplot(121);imshow(bim);            %显示原图像边界
subplot(122),imshow(B2);                  %显示按大小为2的正方形单元近似的边界
