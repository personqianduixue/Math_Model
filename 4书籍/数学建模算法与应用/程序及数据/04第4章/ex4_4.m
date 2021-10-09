clear;clc;
n=6; a=zeros(n);
a(1,2)=50;a(1,4)=40;a(1,5)=25;a(1,6)=10;
a(2,3)=15;a(2,4)=20;a(2,6)=25; a(3,4)=10;a(3,5)=20;
a(4,5)=10;a(4,6)=25; a(5,6)=55;
a=a+a'; 
a(a==0)=inf; %把所有零元素替换成无穷
a([1:n+1:n^2])=0; %对角线元素替换成零，Matlab中数据是逐列存储的
path=zeros(n);
for k=1:n
   for i=1:n
      for j=1:n
         if a(i,j)>a(i,k)+a(k,j)
            a(i,j)=a(i,k)+a(k,j);
            path(i,j)=k;
         end 
      end
   end
end
a, path
