close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
s = 'Find the starting indices of the shorter string.';
a1=findstr(s, 'the');						%在长字符串中查找短字符串
a2=findstr('the', s);
a3=findstr(s,'a');
a4=findstr(s,' ');
a5=strfind(s, 'the');						%在前字符串中查找后字符串
a6=strfind(s, 'a');
a7=strfind('the',s);
