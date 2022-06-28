close all; clear all; clc;					%关闭所有图形窗口，清除工作空间所有变量，清空命令行
stu(1).name='LiMing';					%直接创建结构体stu
stu(1).number='20120101';
stu(1).sex='f';
stu(1).age=20;
stu(2).name='WangHong';
stu(2).number='20120102';
stu(2).sex='m';
stu(2).age=19;
student=struct('name',{'LiMing','WangHong'},'number',{'20120101','20120102'},'sex',{'f','m' },'age',{20,19});
									%应用struct函数创建结构体student
stu;
stu(1);
stu(2);
student;
student(1);
student(2);
