close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
student{1,1}={'LiMing','WangHong'};				%直接赋值法建立细胞数组
student{1,2}={'20120101','20120102'};
student{2,1}={'f','m'};
student{2,2}={20,19};
student;
student{1,1};
student{2,2};
cellplot(student);							%显示细胞数组结构图
close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
stu=cell(2);									%cell函数建立2×2细胞数组
stu{1,1}={'LiMing','WangHong'};
stu{1,2}={'20120101','20120102'};
stu{2,1}={'f','m'};
stu{2,2}={20,19};
stu; 
cellplot(stu)								%显示细胞数组结构图

