function [c,JUG,R]=lkjulei(A,B)  %%%%A表示原始数据，B表示列宽类别,分类，构造按列的高度统计表程序

[m,n]=size(A);
[m1,n1]=size(B);

for i=1:m
    p=0;
    t=1;
   while p==0
        if A(i,4)<=B(t)-2
            b=B(t);
            R(i,1)=A(i,1);
            R(i,2)=A(i,4);
            R(i,3)=A(i,3);
            R(i,4)=b;
            p=1;
        else
            t=t+1;
        end
   end
end
for i=1:n1
JUG{i,1}=R(R(:,4)==B(1,i),3);
end

for i=1:7
    a=JUG{i,1};
    b=tabulate(a);
    b=b(b(:,2)~=0,:);
    [m,n]=size(b);
         for  j=1:m
             c(i,b(j))=b(j,2);
         end
end
c=c(:,28:end);
c=[c;28:125];
c=[[B';0],c];

