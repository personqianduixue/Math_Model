function gaofeng=gaofengqi(y)
x=zeros(size(y,1),size(y,1)-1);
x=y(:,2:end);
gaofeng=[];
for i=1:size(x,1)
    [max1,index1]=max(x(i,:));
    [max2,index2]=max([setdiff(x(i,:),x(i,index1)),0]);
    gaofeng=[gaofeng;i,max1,index1,max2,index2];
end