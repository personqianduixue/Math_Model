close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
f1=@help;								%创建函数句柄
s1=func2str(f1);							%将函数句柄转换成字符串
f2=str2func('help');						%将字符串转换成函数句柄
a1=isa(f1,'function_handle');				%判断f1是否为函数句柄
a2=isequal(f1,f2);						%判断f1和f2是否指向同一函数
a3=functions(f1);						%获取f1信息
