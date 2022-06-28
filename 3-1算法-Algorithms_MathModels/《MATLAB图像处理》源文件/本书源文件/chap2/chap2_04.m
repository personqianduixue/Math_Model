close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
S='Please create a string!';				%创建字符串
[m,n]=size(S);							%计算字符串大小
a=double(S);	 						%计算字符串的ASCII码
S1=lower(S);							%将所有字母转换成小写字母
S2=upper(S);							%将所有字母转换成大写字母
