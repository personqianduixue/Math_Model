close all; clear all; clc;				%关闭所有图形窗口，清除工作空间所有变量，清空命令行
num=rand(3,3);						%产生3×3随机矩阵
s1=num2str(num);					%将数值转换成字符串
s2=num2str(pi,10);					%将pi的前10位转换成字符串
int=12345;							
s3=int2str(int);						%将整数转换成字符串
s4=mat2str(pascal(3));				%将矩阵转换成字符串
num1=str2num('123456');				%将字符串转换成数值
num2=str2double('1234.56');			%将字符串转换成双精度浮点数
