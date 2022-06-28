function  t=gfl(C)%%%%高分类程序

[m,n]=size(C);
t=0;
i=2;
while i<=99
    p=1;
    a=zeros(7,1);
while p==1|i>99
   a=a+C(1:7,i);
   bb=sum(a.*C(1:7,1));
   if sum(a.*C(1:7,1))<=2500
       i=i+1;
   else
       
       t=t+1;
       g(t)=C(8,i-1);
       p=0;
   end
end
end

   
    