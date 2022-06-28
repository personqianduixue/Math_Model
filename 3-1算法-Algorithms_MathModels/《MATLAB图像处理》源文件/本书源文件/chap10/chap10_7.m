%[10.7]
close all; clear all; clc;		%关闭所有图形窗口，清除工作空间所有变量，清空命令行
I=[0 0 1 1 0 0 1 1;1 0 0 1 0 0 1 1;1 1 0 0 0 0 1 0];%待编码的矩阵
[m,n]=size(I);				%计算矩阵大小
I=double(I);
p_table=tabulate(I(:));	%统计矩阵中元素出现的概率，第一列为矩阵元素，第二列为个数，第三列为概率百分数
color=p_table(:,1)';
p=p_table(:,3)'/100;			%转换成小数表示的概率
psum=cumsum(p_table(:,3)');	%计算数组各行的累加值
allLow=[0,psum(1:end-1)/100];%由于矩阵中元素只有两种，将[0,1）区间划分为两个区域allLow和 allHigh 
allHigh=psum/100;
numberlow=0;				%定义算术编码的上下限numberlow和numberhigh
numberhigh=1;
for k=1:m					%以下计算算术编码的上下限，即编码结果
   for kk=1:n
       data=I(k,kk);
       low=allLow(data==color);
       high=allHigh(data==color);
       range=numberhigh-numberlow;
       tmp=numberlow;
       numberlow=tmp+range*low;
       numberhigh=tmp+range*high;
   end
end
fprintf('算术编码范围下限为%16.15f\n\n',numberlow);
fprintf('算术编码范围上限为%16.15f\n\n',numberhigh);
Mat=zeros(m,n);				%解码
for k=1:m
   for kk=1:n
       temp=numberlow<low;
       temp=[temp 1];
       indiff=diff(temp);
       indiff=logical(indiff);
       Mat(k,kk)=color(indiff);
       low=low(indiff);
       high=allHigh(indiff);
       range=high - low;
       numberlow=numberlow-low;
       numberlow=numberlow/range;
   end
end
fprintf('原矩阵为:\n')
disp(I);
fprintf('\n');
fprintf('解码矩阵:\n');
disp(Mat);
