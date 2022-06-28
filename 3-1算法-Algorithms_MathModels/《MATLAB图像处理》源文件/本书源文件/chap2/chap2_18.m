close all; clear all; clc;						%关闭所有图形窗口，清除工作空间所有变量，清空命令行
stu_cell={'LiMing','20120101','M','20'};			%建立细胞数组
celldisp(stu_cell)							%显示细胞数组
fields={'name','number','sex','age'};
stu_struct=cell2struct(stu_cell,fields,2);			%将细胞数组转换成结构体
stu_struct;
a=iscell(stu_cell);							%判断stu_cell是否为细胞数组
b=iscell(stu_struct);
stu_t=struct('name',{'LiMing','WangHong'},'number',{'20120101','20120102'},'sex',{'f','m' },'age',{20,19});
stu_c=struct2cell(stu_t);						%将结构体转换成细胞数组
c= {[1] [2 3 4]; [5; 9] [6 7 8; 10 11 12]};			%建立细胞数组
m= cell2mat(c);								%将细胞数组合并成矩阵
M = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15; 16 17 18 19 20];
C1= mat2cell(M, [2 2], [3 2]);					%将M拆分成细胞数组
C2=num2cell(M);							%将M转换成细胞数组
figure;
subplot(121);cellplot(C1);						%显示C1结构图
subplot(122);cellplot(C2);						%显示C2结构图
