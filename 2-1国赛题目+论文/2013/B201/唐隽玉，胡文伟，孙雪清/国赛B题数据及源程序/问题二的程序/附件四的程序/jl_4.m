clc
jd=[];
for k=1:209
    temp=a{k};
    for i=1:180
        if sum(temp(i,:))<=56
           jd1(i)=0;
        end
        if sum(temp(i,:))>56
           jd1(i)=1;
        end
    end
    jd=[jd jd1'];
end
clear julei
tp=[];m=1;
for i=1:209
    temp=[];
    temp(i)=10000;
    for j=1:209
        if j~=i
            temp(j)=sum(abs(jd(1:100,i)-jd(1:100,j)));
        end
    end
    jm=min(temp);
    pipei1=find(temp>=jm-8);
    pipei2=find(temp<=jm+8);
    pipei3=intersect(pipei1,pipei2);
 
        for q=1:length(tp)
            AAA=find(pipei3==tp(q));
            pipei3(AAA)=[];
        end
        tp=[tp,pipei3];
    if isempty(find(tp==i)) 
        pipei3=[i,pipei3];
        julei{m}=pipei3;
        tp=[tp,julei{m}];
        m=m+1;
    end
end
