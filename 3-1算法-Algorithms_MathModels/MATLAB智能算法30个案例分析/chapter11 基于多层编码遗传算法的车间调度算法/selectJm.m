function SelS=selectJm(S,S_T)

Num=length(S_T);

MaxVal=0;
for i=1:Num
  if S_T(i)>MaxVal;
   MaxVal=S_T(i);
  end
end
MaxVal=2*MaxVal;

for i=1:Num
 S_T(i)=MaxVal-S_T(i);
end

eVal=0;
for i=1:Num
 eVal=eVal+S_T(i);
end

for i=1:Num
 P(i)=S_T(i)/eVal;
end

for i=2:Num
  P(i)=P(i)+P(i-1);
end

 num=rand;
 SelS=1;
 while(num>P(SelS))
     SelS=SelS+1;    
 end
 
