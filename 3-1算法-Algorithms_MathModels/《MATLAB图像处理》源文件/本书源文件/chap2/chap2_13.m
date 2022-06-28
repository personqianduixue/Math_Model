close all; clear all; clc;			%关闭所有图形窗口，清除工作空间所有变量，清空命令行
fhandle=@sin;					%建立一个函数句柄
y1=fhandle(2*pi);				%用函数句柄调用函数
y2=sin(2*pi);					%直接调用函数
