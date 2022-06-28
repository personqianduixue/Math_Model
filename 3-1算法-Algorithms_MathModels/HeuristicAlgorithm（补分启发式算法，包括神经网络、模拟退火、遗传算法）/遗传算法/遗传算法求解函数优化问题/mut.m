%“变异”操作
function snnew=mut(snew,pm);

bn=size(snew,2);
snnew=snew;

pmm=pro(pm);  %根据变异概率决定是否进行变异操作，1则是，0则否
if pmm==1
   chb=round(rand*(bn-1))+1;  %在[1,bn]范围内随机产生一个变异位
   snnew(chb)=abs(snew(chb)-1);
end   