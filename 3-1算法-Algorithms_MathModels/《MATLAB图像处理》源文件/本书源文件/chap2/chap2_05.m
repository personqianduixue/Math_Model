close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
S1='How are you!   ';					%创建S1字符串
S2='Fine, Thank you!';					%创建S2字符串
A=[S1,S2];                          	%合并字符数组
B=char(S1,S2);							%连接字符串S1和S2
C=strcat(S1,S2);						%横向连接字符串S1和S2
D=strvcat(S1,S2);						%纵向连接字符串S1和S2
E=S2(7:16);                             %拆分截取字符串S2
