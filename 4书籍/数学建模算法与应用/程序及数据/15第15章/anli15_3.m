clc, clear
a=load('jishu.txt');  %把表15.15中的数据保存到纯文本文件jishu.txt中
t=a([1,3],:); t=t(:); %提取时间t数据，并变成列向量，这里t没有顺序
n=a([2,4],:); n=n(:); %提取计算器读数n的数据
xishu=[n.^2,n]; %构造系数阵
ab=xishu\t
n0=4450
that=ab(1)*n0^2+ab(2)*n0