close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
s1 = 'This is a good example.';
s2=strrep(s1, 'good', 'great');				%在在符串中查找good用great替换
s3=strrep(s1,'Good','great');
