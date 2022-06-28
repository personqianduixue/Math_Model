%Yucebianma 函数用一维预测编码压缩图像x,f为预测系数，建立Yucebianma.m文件
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
