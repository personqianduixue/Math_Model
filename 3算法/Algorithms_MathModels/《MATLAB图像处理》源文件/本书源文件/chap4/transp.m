function J=transp(I)
%I表示输入的原始图像
%J表示经过转置以后的图像
[M,N,G]=size(I);%获取输入图像I的大小
I=im2double(I); %将图像数据类型转换成双精度
J=ones(N,M,G);  %初始化新图像矩阵全为1，大小与输入图像相同
for i=1:M
    for j=1:N
      J(j,i,:)=I(i,j,:);%进行图像转置    
    end
end