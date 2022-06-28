%[10.9]
close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
J=imread('eye.bmp');  				%装入图像，用 Yucebianma进行线性预测编码，用Yucejiema解码
X=double(J);
Y=Yucebianma(X);
XX=Yucejiema(Y);
e=double(X)-double(XX);[m,n]=size(e);
erm=sqrt(sum(e(:).^2)/(m*n));	
set(0,'defaultFigurePosition',[100,100,1000,500]);%修改图形图像位置的默认设置
set(0,'defaultFigureColor',[1 1 1])
figure,
subplot(121);imshow(J);
subplot(122),imshow(mat2gray(255-Y));	 %为方便显示，对预测误差图取反后再作显示
figure;	
[h,x]=hist(X(:));%显示原图直方图
subplot(121);bar(x,h,'k');
[h,x]=hist(Y(:));
subplot(122);bar(x,h,'k');
%Yucebianma 函数用一维预测编码压缩图像x,f为预测系数，如果f去默认值，则默认f=1,就是前值预测
function y=Yucebianma(x,f)
error(nargchk(1,2,nargin))
if nargin<2
  f=1;
end
x=double(x);
[m,n]=size(x); 
p=zeros(m,n);  					 %存放预测值
xs=x;
zc=zeros(m,1);
for j=1:length(f)
    xs=[zc xs(:,1:end-1)];
    p=p+f(j)*xs;
end
y=x-round(p);
%Yucejiema是解码程序，与编码程序用的是同一个预测器
function x=Yucejiema(y,f)
error(nargchk(1,2,nargin));
if nargin<2
  f=1;
end
f=f(end:-1:1);
[m,n]=size(y);
order=length(f);
f=repmat(f,m,1);
x=zeros(m,n+order);
for j=1:n
  jj=j+order;
  x(:,jj)=y(:,j)+round(sum(f(:,order:-1:1).*x(:,(jj-1):-1:(jj-order)),2));
end
x=x(:,order+1:end);
