f=imread('Lena.bmp');
f=double(f)   %uint8类型数据无法做奇异值分解，必须转换成double类型
[u,s,v]=svd(f); %进行奇异值分解,这里s为对角矩阵
s=diag(s); %提出对角矩阵的对角线元素，得到一个向量
smax=max(s), smin=min(s) %求最大奇异值和最小奇异值
s1=s; s1(21:end)=0; %只保留前20个大的奇异值，其它奇异值置0
s1=diag(s1);  %把向量变成对角矩阵
g=u*s1*v';    %计算压缩以后的图像矩阵
g=uint8(g);   %必须转换成原数据类，即转换成uint8格式
imwrite(g,'Lena2.bmp') %把压缩后的图像矩阵保存成bmp文件
subplot(1,2,1), imshow('Lena.bmp') %显示原图像
subplot(1,2,2), imshow(g) %显示压缩后的图像
figure, plot(s,'.','Color','k') %画出奇异值对应的点
