%【例11-6】
%步骤1：定义自相关函数zxcor()，建立zxcor.m文件
function [epsilon,eta,C]=zxcor(f,D,m,n)  
%自相关函数zxcor(),f为读入的图像数据，D为偏移距离，【m，n】是图像的尺寸数据，返回图像相关函数C的
%值，epsilon和eta是自相关函数C的偏移变量。
for epsilon=1:D									%循环求解图像f(x,y)与偏离值为D的像素之间的相关值
  for eta=1:D                
     temp=0;
     fp=0;
     for x=1:m
        for y=1:n
           if(x+ epsilon -1)>m|(y+ eta -1)>n
             f1=0;
           else   
            f1=f(x,y)*f(x+ epsilon -1,y+ eta -1);     
           end
           temp=f1+temp;
           fp=f(x,y)*f(x,y)+fp;
        end      
     end 
        f2(epsilon, eta)=temp;
        f3(epsilon, eta)=fp;
        C(epsilon, eta)= f2(epsilon, eta)/ f3(epsilon, eta);		%相关值C
   end
end
epsilon =0:(D-1);									% 方向的取值范围
eta =0:(D-1);										% 方向的取值范围
%步骤2：调用zxcor()函数，分析不同图像的纹理特征。
f11=imread('wall.jpg');								%读入砖墙面图像，图像数据赋值给f
f1=rgb2gray(f11);									%彩色图像转换成灰度图像
f1=double(f1);										%图像数据变为double类型
[m,n]=size(f1);										%图像大小赋值为[m,n]
D=20;											%偏移量为20
[epsilon1,eta1,C1]=zxcor1(f1,D,m,n);						%调用自相关函数
f22=imread('stone.jpg');								%读入大理石图像，图像数据赋值给f
f2=rgb2gray(f22);
f2=double(f2);
[m,n]=size(f2);
[epsilon2,eta2,C2]=zxcor1(f2,20,m,n);					%调用自相关函数
set(0,'defaultFigurePosition',[100,100,1000,500]);			%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1]);
figure;subplot(121);imshow(f11);
subplot(122);imshow(f22);
figure;subplot(121);mesh(epsilon1,eta1,C1);				%显示自相关函数与x，y的三维图像
xlabel(' epsilon ');ylabel(' eta ');							%标示坐标轴变量
subplot(122);mesh(epsilon2,eta2,C2);	
xlabel(' epsilon ');ylabel(' eta ');	

