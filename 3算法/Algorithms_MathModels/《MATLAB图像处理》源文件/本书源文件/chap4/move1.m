function J=move1(I,a,b) 
% 定义一个函数名字move，I表示输入图像，a和b描述I图像沿着x轴和y轴移动的距离
% 考虑平移以后，图像溢出情况，采用扩大显示区域的方法
[M,N,G]=size(I);%获取输入图像I的大小
I=im2double(I); %将图像数据类型转换成双精度
J=ones(M+abs(a),N+abs(b),G);  %初始化新图像矩阵全为1，大小根据考虑x轴和y轴的平移范围
for i=1:M
 for j=1:N
  if(a<0 && b<0);%如果进行右下移动，对新图像矩阵进行赋值
     J(i,j,:)=I(i,j,:);
  else if(a>0 && b>0);
     J(i+a,j+b,:)=I(i,j,:);%如果进行右上移动，对新图像矩阵进行赋值
  else if(a>0 && b<0);
     J(i+a,j,:)=I(i,j,:);%如果进行左上移动，对新图像矩阵进行赋值
  else
     J(i,j+b,:)=I(i,j,:);%如果进行右下移动，对新图像矩阵进行赋值
     end
    end
   end
  end
end