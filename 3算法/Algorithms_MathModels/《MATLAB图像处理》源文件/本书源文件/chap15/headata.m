function [fp,axes_x,axes_y,pixel]=headata(N)
%N表示创建头文件的大小；fp表示存储头模型数据文件的指针头；
%axes_x和axes_y表示的文件绘图坐标范围；
%pixel为头模型数据矩阵；
%具体调用形式[fp,axes_x,axes_y,pixel]=headata(N)。
 lenth=N*N;
 pixel=zeros(N,N);%生成图像的密度矩阵，初值为零
 coordx=[0,0,0.22,-0.22,0,0,0,-0.08,0,0.06];%每个椭圆中心的x坐标，各个椭圆代表不同组织
 coordy=[0,-0.0184,0,0,0.35,0.1,-0.1,-0.605,-0.605,-0.605];%每个椭圆中心的y坐标；
 laxes=[0.92,0.874,0.31,0.41,0.25,0.046,0.046,0.046,0.023,0.046];%每个椭圆长轴的大小
 saxes=[0.69,0.6624,0.11,0.16,0.21,0.046,0.046,0.023,0.023,0.023];%每个椭圆短轴的大小
 angle=[90,90,72,108,90,0,0,0,0,90];%每个椭圆旋转的角度
 density=[2.0,-0.98,-0.4,-0.4,0.2,0.2,0.2,0.2,0.2,0.3];%每个椭圆的灰度值
   for i=1:N,
        for j=1:N,
            for k=1:10,
                axes_x(i,j)=(-1+j*2/N-0.5*2/N);%画图像时的x坐标
                x=(-1+j*2/N)-coordx(k);
                axes_y(i,j)=(-1+i*2/N-0.5*2/N);%画图像时的y坐标
                y=(-1+i*2/N)-coordy(k);
                alpha=pi*angle(k)/180;
                a=(x*cos(alpha)+y*sin(alpha))/laxes(k);%判断像素点是否在第k个椭圆里
                b=(-x*sin(alpha)+y*cos(alpha))/saxes(k);
                if((a*a+b*b)<=1)
                pixel(i,j)=density(k)+pixel(i,j);
                end
            end
        end
   end
 fp=fopen('datafile_name.txt','w'); %创建头模型数据文件，对其进行写操作
 for i=1:N,
    for j=1:N,
            a=[i j pixel(i,j)];
            fprintf(fp,'%d  %d  %f\n',a);
    end
 end
fclose(fp);%关闭文件指针
fp=fopen('datafile_name.txt','r'); %保存datafile_name.txt文件头

 
