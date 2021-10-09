function J=move(I,a,b) 
% 定义一个函数名字move，I表示输入图像，a和b描述I图像沿着x轴和y轴移动的距离
% 不考虑平移以后，图像溢出情况，找不到对应点的地方都赋值为1
[M,N,G]=size(I);%获取输入图像I的大小
I=im2double(I); %将图像数据类型转换成双精度
J=ones(M,N,G);  %初始化新图像矩阵全为1，大小与输入图像相同
for i=1:M
    for j=1:N
        if((i+a)>=1&&(i+a<=M)&&(j+b>=1)&&(j+b<=N));%判断平移以后行列坐标是否超出范围
            J(i+a,j+b,:)=I(i,j,:);%进行图像平移
        end
    end
end