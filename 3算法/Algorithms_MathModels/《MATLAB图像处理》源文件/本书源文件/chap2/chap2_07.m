close all; clear all; clc;				%关闭所有图形窗口，清除工作空间所有变量，清空命令行
S1='Good morning!';
S2='good morning, Sir.';
a=strcmp(S1,S2);					%比较两个字符串大小
b=strncmp(S1,S2,7);					%比较两个字符串前7个字符大小，区分大小写
c=strncmpi(S1,S2,7);				%比较两个字符串前7个字符大小，不区分大小写
