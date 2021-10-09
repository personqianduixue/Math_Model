clc;clear
m=7; %子序列
k=3;%序列长度
X0=[];%差序列矩阵
R0=[];%关联系数矩阵


xindata=[0.000155101	1	0.5
8.54803E-05	1	0.5
5.28503E-05	1	0.5
9.5186E-05	1	0.5
0.000131515	1	0.5
0.00012995	1	0.5
0.000155101	1	0.5
0.000147684	1	0.5]';

mean1=mean(xindata,2);

% 第二步：求各序列的初值像
for i=1:k
x1(i,:)=xindata(i,:)./mean1(i,1); 
end
%x2=x1.^2;
%s=sqrt(sum(x2,2)/(k-1))

%for i=1:m+1
%x2(i,:)=(x(i,:)-mean1(i,1))/s(i,1); %均值化数据
%end

x1=x1';
x0=x1(1,:);
X=x1(2:m+1,:);
% x0=x1(:,1);
% X=x1(:,2:m+1);


% 第三步：求差序列
for i=1:m
    for ii=1:k
      X0(i,ii)=abs(x0(ii)-X(i,ii));
    end
end

% 第四步：求两极差
Max=max(max(X0));  
Min=min(min(X0));

% 第五步：求关联系数
for i=1:m
    for ii=1:k
      R0(i,ii)=(Min+0.5*Max)/(Min+0.5*Max+X0(i,ii));
    end
end




% 第六步：求关联度
r=sum(R0)/k;

% 第七步：显示结果
disp('关联度依次为:')
disp(r)

