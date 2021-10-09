clc;clear glei
jda=[];jdb=[];
jd=[];
for k=1:209
    temp=a{k};
    for i=1:180
        if sum(temp(i,:))~=72
           jd(i)=0;
        end
        if sum(temp(i,:))==72
           jd(i)=1;
        end
    end
    jda=[jda jd'];
end
jd=[];
for k=1:209
    temp=b{k};
    for i=1:180
        if sum(temp(i,:))~=72
           jd(i)=0;
        end
        if sum(temp(i,:))==72
           jd(i)=1;
        end
    end
    jdb=[jdb jd'];
end
nm=1;tep=[];
for j=1:209
tl=[];xu=j;
for i=1:209
    if i~=xu && isempty(find(tep==i))
        ch1=sum(abs(jda(:,xu)-jda(:,i)));ch2=sum(abs(jda(:,xu)-jdb(:,i)));
        ch3=sum(abs(jdb(:,xu)-jda(:,i)));ch4=sum(abs(jdb(:,xu)-jdb(:,i)));
        [chm,ind]=min([ch1,ch2,ch3,ch4]);
        if chm<=18
            if ind(1)==1 
                chch=abs(jdb(:,1)-jdb(:,i));
            end
            if ind(1)==2
                chch=abs(jdb(:,1)-jda(:,i));
            end
            if ind(1)==3
                chch=abs(jda(:,1)-jdb(:,i));
            end
            if ind(1)==4
                chch=abs(jda(:,1)-jda(:,i));
            end
            if chch<=1
                tl=[tl i];
            end
        end
    end
end
tep=[];
if nm>1
for tt=1:nm-1
    tep=[tep,glei{tt}];
end
end
if isempty(find(tep==xu))
glei{nm}=[xu tl];
nm=nm+1;
end
end
            

