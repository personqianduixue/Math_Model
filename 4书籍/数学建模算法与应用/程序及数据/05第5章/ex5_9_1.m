x0=-10:0.01:10;
y0=normpdf(x0,0,1);  %计算标准正态分布密度函数在x0处的取值
save data2 x0 y0   %把x0，y0保存到文件data2.mat中
