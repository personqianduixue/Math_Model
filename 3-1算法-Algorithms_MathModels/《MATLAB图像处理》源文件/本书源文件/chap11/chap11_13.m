%【例11-13】
I= imread('leaf1.bmp');                           %读入图像 　　
c= im2bw(I, graythresh(I));                        %I转换为二值图像
set(0,'defaultFigurePosition',[100,100,1000,500]);	 %修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure;subplot(131);imshow(I);                     %显示原图
c=flipud(c);                                      %实现矩阵c上下翻转              
b=edge(c,'canny');                               %基于canny算子进行轮廓提取
[u,v]=find(b);                                    %返回边界矩阵b中非零元素的位置
xp=v;                                          %行值v赋给xp
yp=u;                                          %列值u赋给yp 
x0=mean([min(xp),max(xp)]);                     %x0为行值的均值
y0=mean([min(yp),max(yp)]);                      %y0为列值的均值
xp1=xp-x0;
yp1=yp-y0;
[cita,r]=cart2pol(xp1,yp1);                         %直角坐标转换成极坐标
q=sortrows([cita,r]);                              %从r列开始比较数值并按升序排序
cita=q(:,1);                                      %赋角度值
r=q(:,2);                                         %赋半径模值
subplot(132);polar(cita,r);                          %画出极坐标下的轮廓图
[x,y]=pol2cart(cita,r);
x=x+x0;
y=y+y0;
subplot(133);plot(x,y);                            %画出直角坐标下的轮廓图
