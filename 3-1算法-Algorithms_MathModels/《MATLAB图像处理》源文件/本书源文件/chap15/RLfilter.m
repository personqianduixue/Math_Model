function [axes_x,h]=RLfilter(N,L)
%定义量化值N
delta=L/N;			%对滤波函数进行离散化单位量
for i=2:2:2*N 	%偶数项=0
    h(i)=0; 
end
k=1/delta/delta;         %原点项=0
h(N)=k/4;
for i=1:2:N-1
  down=-k/(i*i*pi*pi);   %奇数项=-1/(n^2 π^2 d^2 )
  h(N+i)=down;
  h(N-i)=down;
end
for i=1:2*N
axes_x(i)=(-1+(i-1)/N);%画图像时的x坐标
end


