close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
A=magic(4);
B=[1,2,3;5,5,7;6,3,4;9,4,7];
figure;
subplot(121);bar(A);				%画出A的柱状图
subplot(122);barh(B);			%画出B的柱状图
