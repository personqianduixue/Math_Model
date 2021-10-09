clc;clear;
a=zeros(7);
a(1,2)=50; a(1,3)=60;
a(2,4)=65; a(2,5)=40;
a(3,4)=52;a(3,7)=45;
a(4,5)=50; a(4,6)=30;a(4,7)=42;
a(5,6)=70; 
a=a+a';a(a==0)=inf;
result=[];p=1;tb=2:length(a);
while size(result,2)~=length(a)-1
   temp=a(p,tb);temp=temp(:);
   d=min(temp);
   [jb,kb]=find(a(p,tb)==d);
   j=p(jb(1));k=tb(kb(1));
   result=[result,[j;k;d]];p=[p,k];tb(find(tb==k))=[];
end
result
