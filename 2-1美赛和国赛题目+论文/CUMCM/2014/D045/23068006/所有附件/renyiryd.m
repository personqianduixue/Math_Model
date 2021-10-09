function R=renyiryd(A,B)  %%%%A表示原始数据，B表示列宽类别

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
            R(i,3)=b;
            R(i,4)=b-A(i,4)-2;
            p=1;
        else
            t=t+1;
        end
   end
end
            