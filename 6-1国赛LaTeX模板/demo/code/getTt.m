function T = getTt(alpha,beta)
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global T_real index
global Data
global len0 len1 len2 len3 len4 len5
size_x=floor(d/deltax);
size_t=len5;
Tt=zeros(size_x,size_t);
Tt(:,1)=25;
A=cell(1,5);B=cell(1,5);C=cell(1,5);
i=1;
for r=alpha*deltat/(deltax^2)
    A{i}=diag([1+beta*deltax,2*ones(1,size_x-2)*(1+r),1+beta*deltax]);
    A{i}=A{i}+diag([-1,-r*ones(1,size_x-2)],1);
    A{i}=A{i}+diag([-r*ones(1,size_x-2),-1],-1);

    B{i}=diag([0,2*ones(1,size_x-2)*(1-r),0]);
    B{i}=B{i}+diag([0,r*ones(1,size_x-2)],1);
    B{i}=B{i}+diag([r*ones(1,size_x-2),0],-1);
    C{i}=A{i}\B{i};
    i=i+1;
end
for i=1:len1-1
    c=zeros(size_x,1); c(1)=beta*deltax*ts(i); c(size_x)=beta*deltax*ts(i); c=A{1}\c;
    Tt(:,i+1)=C{1}*Tt(:,i)+c;
end
for i=len1:len2-1
    c=zeros(size_x,1); c(1)=beta*deltax*ts(i); c(size_x)=beta*deltax*ts(i); c=A{2}\c;
    Tt(:,i+1)=C{2}*Tt(:,i)+c;
end
for i=len2:len3-1
    c=zeros(size_x,1); c(1)=beta*deltax*ts(i); c(size_x)=beta*deltax*ts(i); c=A{3}\c;
    Tt(:,i+1)=C{3}*Tt(:,i)+c;
end
for i=len3:len4-1
    c=zeros(size_x,1); c(1)=beta*deltax*ts(i); c(size_x)=beta*deltax*ts(i); c=A{4}\c;
    Tt(:,i+1)=C{4}*Tt(:,i)+c;
end
for i=len4:len5
    c=zeros(size_x,1); c(1)=beta*deltax*ts(i); c(size_x)=beta*deltax*ts(i); c=A{5}\c;
    Tt(:,i+1)=C{5}*Tt(:,i)+c;
end
T=Tt(floor(size_x/2),:);