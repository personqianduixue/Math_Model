function degree=projdata(proj,N)
%proj表示投影数;
%N表示投影轴R的采样点数;
%具体的调用格式degree=projdata(proj,N)
NUM=10;%椭圆的个数
%ellipse定义十个椭圆，其中一个[]描述一个椭圆相关参数，每个椭圆对应不同组织
%[]椭圆的定义依次X0，Y0，长轴，短轴，旋转角度，灰度值
%定义一个椭圆矩阵，将十个椭圆描述清楚，采用的是cell格式
ellipse={[0,0,0.92,0.69,90,2.0],    
         [0,-0.0184,0.874,0.6624,90,0.98],
         [0.22,0,0.31,0.11,72,-0.4],
         [-0.22,0,0.41,0.16,108,-0.4],
         [0,0.35,0.25,0.21,90,0.4],
         [0,0.1,0.046,0.046,0,0.4],
         [0,-0.1,0.046,0.046,0,0.4],
         [-0.08,-0.605,0.046,0.023,0,0.4],
         [0,-0.605,0.023,0.023,0,0.4],
         [0.06,-0.605,0.046,0.023,90,0.4]};
  step=180/proj;%投影角旋转的增量
  for i=1:NUM
   a(i)=ellipse{i,1}(3);%第i个椭圆的长轴
   b(i)=ellipse{i,1}(4);%第i个椭圆的短轴
   c(i)=2*a(i)*b(i);% 2*长轴*短轴
   a2(i)=a(i)*a(i);%长轴平方，矩阵a2 1*10
   b2(i)=b(i)*b(i);%短轴平方，矩阵b2 1*10
   alpha(i)=ellipse{i,1}(5)*pi/180;%第i个椭圆旋转的角度转化成弧度
   sina(i)=sin(alpha(i));%sin(alpha)
   cosa(i)=cos(alpha(i));%cos(alpha)
  end
 for j=1:proj
   for i=1:NUM
     theta(j)=step*j*pi/180;%theta投影线的与x轴夹角
     angle(i,j)=alpha(i)-theta(j);%alpha表示椭圆的中心线与x轴夹角;
     zx2(i,j)=sin(angle(i,j))*sin(angle(i,j));%zx2=sin平方
     yx2(i,j)=cos(angle(i,j))*cos(angle(i,j));%yx2=cos平方
   end
 end
 length=2/N;
for i=1:proj
  R=-(N/2)*length;
  for j=1:N
    R=R+length;
    degree(i,j)=0;
      for m=1:10
        A=a2(m)*yx2(m,i)+b2(m)*zx2(m,i);%a2(m)相应椭圆长轴a的平方，yx2(m,i)余旋平方
        x0=ellipse{m,1}(1);
        y0=ellipse{m,1}(2);
        B=R-x0*cos(theta(i))-y0*sin(theta(i));%计算投影值
        B=B*B;
        E=A-B;
        if (E>0) 
         midu=ellipse{m,1}(6)*c(m)*sqrt(E)/A;
         degree(i,j)=degree(i,j)+midu;
        end
      end 
  end
end





