function main
a=zeros(6);
a(1,2)=56;a(1,3)=35;a(1,4)=21;a(1,5)=51;a(1,6)=60;
a(2,3)=21;a(2,4)=57;a(2,5)=78;a(2,6)=70; a(3,4)=36;a(3,5)=68;a(3,6)=68; a(4,5)=51;a(4,6)=61;
a(5,6)=13; a=a+a'; L=size(a,1);
c=[5 1:4 6 5]; %选取初始圈
[circle,long]=modifycircle(a,L,c)  %调用下面修改圈的子函数
%*******************************************
%以下为修改圈的子函数
%*******************************************
function [circle,long]=modifycircle(a,L,c);
for k=1:L
flag=0;   %退出标志
for m=1:L-2   %m为算法中的i
for n=m+2:L   %n为算法中的j
 if a(c(m),c(n))+a(c(m+1),c(n+1))<a(c(m),c(m+1))+a(c(n),c(n+1))
      c(m+1:n)=c(n:-1:m+1); flag=flag+1; %修改一次，标志加1
 end
end
end
     if flag==0   %一条边也没有修改,就返回
       long=0;   %圈长的初始值
       for i=1:L
         long=long+a(c(i),c(i+1)); %求改良圈的长度
       end
       circle=c;   %返回修改圈
       return
     end
end
