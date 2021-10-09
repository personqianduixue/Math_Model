clc,clear
load r.txt  %原始的相关系数矩阵保存在纯文本文件r.txt中
n1=5;n2=7;num=min(n1,n2);
s1=r([1:n1],[1:n1]);  %提出X与X的相关系数
s12=r([1:n1],[n1+1:end]); %提出X与Y的相关系数
s21=s12'; %提出Y与X的相关系数
s2=r([n1+1:end],[n1+1:end]); %提出Y与Y的相关系数
m1=inv(s1)*s12*inv(s2)*s21; %计算矩阵M1，式（10.60）
m2=inv(s2)*s21*inv(s1)*s12; %计算矩阵M2，式（10.60）
[vec1,val1]=eig(m1); %求M1的特征向量和特征值
for i=1:n1
    vec1(:,i)=vec1(:,i)/sqrt(vec1(:,i)'*s1*vec1(:,i)); %特征向量归一化，满足a's1a=1
    vec1(:,i)=vec1(:,i)/sign(sum(vec1(:,i))); %特征向量乘以1或－1，保证所有分量和为正
end
val1=sqrt(diag(val1));    %计算特征值的平方根
[val1,ind1]=sort(val1,'descend');  %按照从大到小排列
a=vec1(:,ind1(1:num))    %取出X组的系数阵
dcoef1=val1(1:num)    %提出典型相关系数
flag=1; %把计算结果写到Excel中的行计数变量
xlswrite('bk.xls',a,'Sheet1','A1')   %把计算结果写到Excel文件中去
flag=n1+2; str=char(['A',int2str(flag)]); %str为Excel中写数据的起始位置
xlswrite('bk.xls',dcoef1','Sheet1',str)
[vec2,val2]=eig(m2);  
for i=1:n2
    vec2(:,i)=vec2(:,i)/sqrt(vec2(:,i)'*s2*vec2(:,i)); %特征向量归一化，满足b's2b=1
    vec2(:,i)=vec2(:,i)/sign(sum(vec2(:,i))); %特征向量乘以1或－1，保证所有分量和为正
end
val2=sqrt(diag(val2));    %计算特征值的平方根
[val2,ind2]=sort(val2,'descend');  %按照从大到小排列
b=vec2(:,ind2(1:num))    %取出Y组的系数阵
dcoef2=val2(1:num)    %提出典型相关系数
flag=flag+2; str=char(['A',int2str(flag)]); %str为Excel中写数据的起始位置
xlswrite('bk.xls',b,'Sheet1',str)
flag=flag+n2+1; str=char(['A',int2str(flag)]); %str为Excel中写数据的起始位置
xlswrite('bk.xls',dcoef2','Sheet1',str)
x_u_r=s1*a     %x,u的相关系数
y_v_r=s2*b     %y,v的相关系数
x_v_r=s12*b    %x,v的相关系数
y_u_r=s21*a    %y,u的相关系数
flag=flag+2; str=char(['A',int2str(flag)]); 
xlswrite('bk.xls',x_u_r,'Sheet1',str)
flag=flag+n1+1; str=char(['A',int2str(flag)]);
xlswrite('bk.xls',y_v_r,'Sheet1',str)
flag=flag+n2+1; str=char(['A',int2str(flag)]);
xlswrite('bk.xls',x_v_r,'Sheet1',str)
flag=flag+n1+1; str=char(['A',int2str(flag)]);
xlswrite('bk.xls',y_u_r,'Sheet1',str)
mu=sum(x_u_r.^2)/n1   %x组原始变量被u_i解释的方差比例
mv=sum(x_v_r.^2)/n1   %x组原始变量被v_i解释的方差比例
nu=sum(y_u_r.^2)/n2   %y组原始变量被u_i解释的方差比例
nv=sum(y_v_r.^2)/n2   %y组原始变量被v_i解释的方差比例
fprintf('X组的原始变量被u1~u%d解释的比例为%f\n',num,sum(mu));
fprintf('Y组的原始变量被v1~v%d解释的比例为%f\n',num,sum(nv));
