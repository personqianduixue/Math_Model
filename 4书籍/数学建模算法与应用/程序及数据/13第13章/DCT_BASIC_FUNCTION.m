clc, clear, T=dctmtx(8); %8×8的DCT变换矩阵
colormap('gray'); %设置颜色映射矩阵
for m = 1:8
for n = 1:8
subplot(8,8,(m-1)*8+n);
Y=zeros(8); Y(m,n)=1; %8×8矩阵中，只有第m行第n列为1，其余元素都为0
X = T'*Y*T; %做逆DCT变换
imagesc(X); %显示图像
axis square %画图区域是方形
axis off %不显示轴线和标号
end
end
