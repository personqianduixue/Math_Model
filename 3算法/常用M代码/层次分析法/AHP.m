clc,clear 
fid=fopen('txt3.txt','r'); 
n1=6;
n2=3; 
a=[]; 
for i=1:(n1)+1 
    tmp=str2num(fgetl(fid)); 
    a=[a;tmp];                               %读准则层判断矩阵 
end 
for i=1:n1 
     str1=char(['b',int2str(i),'=[];']); 
     str2=char(['b',int2str(i),'=[b',int2str(i),';tmp];']); 
     eval(str1); 
     for j=1:n2 
          tmp=str2num(fgetl(fid)); 
          eval(str2);                       %方案层的判断矩阵读 
     end   
end 
ri=[0,0,0.58,0.90,1.12,1.24,1.32,1.41,1.45]; %一致性指标 
 [x,y]=eig(a);                                %求解特征向量 x为特征向量 y为特征值             
lamda=max(diag(y)); 
num=find(diag(y)==lamda); 
w0=x(:,num)/sum(x(:,num));                   %求解权系数
cr0=(lamda-n1)/(n1-1)/ri(n1)                 %一致性比例求解
for i=1:n1 
    [x,y]=eig(eval(char(['b',int2str(i)]))); 
    lamda=max(diag(y)); 
    num=find(diag(y)==lamda); 
    w1(:,i)=x(:,num)/sum(x(:,num)); 
    cr1(i)=(lamda-n2)/(n2-1)/ri(n2);           %一致性比例求解
end 
cr1, ts=w1*w0, cr=cr1*w0 