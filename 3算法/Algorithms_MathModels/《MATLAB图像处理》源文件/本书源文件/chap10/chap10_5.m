%【10-5】
close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
p=[0.5 0.19 0.19 0.12]			%输入信息符号对应的概率
n=length(p);					%输入概率的个数
y=fliplr(sort(p));					%大到小排序
D=zeros(n,4);					%生成n*4的零矩阵
D(:,1)=y';						%把y赋给零矩阵的第一列
for i=2:n
D(1,2)=0;						%令第一行第二列的元素为0
D(i,2)=D(i-1,1)+D(i-1,2);			%求累加概率
 end
   for i=1:n
D(i,3)=-log2(D(i,1));				%求第三列的元素
D(i,4)=ceil(D(i,3));				%求第四列的元素，对D(i,3)向无穷方向取最小正整数
   end
D
A=D(:,2)';						%取出D中第二列元素
B=D(:,4)';						%取出D中第四列元素
for j=1:n
C=binary(A(j),B(j))				%生成码字
end 
%建立binary.m文件，自定义求小数的二进制转换函数
function [C]=binary(A,B)			%对累加概率求二进制的函数
C=zeros(1,B);					%生成零矩阵用于存储生成的二进制数，对二进制的每一位进行操作
temp=A;						%temp赋初值
for i=1:B						%累加概率转化为二进制，循环求二进制的每一位，A控制生成二进制的位数
  temp=temp*2;
if temp>=1
  temp=temp-1;
 C(1,i)=1;
  else
 C(1,i)=0;
  end
 end
