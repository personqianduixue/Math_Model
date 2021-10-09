close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
S1='My name is Tommy';
S2='Nice to meet you';
a=S1==S2;					%判断两个字符串是否相等
b=S1>S2;						%判断S1是否大于S2
c=lt(S1,S2);					%应用函数判断S1是否小于S2
d=S1<S2;						%判断S1是否小于S2
