%例【11-5】灰度差分统计特征计算，分析纹理图像
J=imread('wall.jpg');                    %读入纹理图像，分别输入wall.jpg和stone.jpg两幅图进行对比
A=double(J);
[m,n]=size(A);                         %求A矩阵的大小，赋值给m n
B=A;
C=zeros(m,n);                         %新建全零矩阵C，以下求解归一化的灰度直方图
for i=1:m-1
    for j=1:n-1
        B(i,j)=A(i+1,j+1);
        C(i,j)=abs(round(A(i,j)-B(i,j)));
    end
end
h=imhist(mat2gray(C))/(m*n);
mean=0;con=0;ent=0;                    % 均值mean、对比度con和熵ent初始值赋零
for i=1:256                              %循环求解均值mean、对比度con和熵ent          
    mean=mean+(i*h(i))/256;
    con=con+i*i*h(i);
    if(h(i)>0)
        ent=ent-h(i)*log2(h(i));
    end
end
    mean,con,ent


    