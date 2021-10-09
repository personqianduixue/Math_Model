close all;                  %关闭当前所有图形窗口，清空工作空间变量，清除工作空间所有变量
clear all;
clc;
s1=2^8;                      %设置分解信号、数值向量、数值矩阵           
s2=[2^8 2^7];
s3=[2^9 2^7;2^9 2^7]; 
w1='db1';                   %设置分解采用的小波
w2='db2';
disp('一维信号s1采用db1的最大分解层数L1') %计算并显示最大分解层数
L1=wmaxlev(s1,w1)
disp('数值向量s2采用db1的最大分解层数L2')
L2=wmaxlev(s2,w1)
disp('数值矩阵s3采用db1的最大分解层数L3')
L3=wmaxlev(s3,w1)
disp('数值矩阵s3采用db7的最大分解层数L4')
L4=wmaxlev(s3,w2)