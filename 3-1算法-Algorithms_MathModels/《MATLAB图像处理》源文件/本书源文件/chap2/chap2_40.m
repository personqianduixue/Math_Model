close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
try									%打开一个文件名为girl.bmp的文件，若文件不存在，则打开
picture=imread('girl.bmp','bmp');		%一个文件名为girl.jpg的文件
filename='girl.bmp';
catch
picture=imread('girl.jpg','jpg');
filename='girl.jpg';
end
filename;
lasterror;
