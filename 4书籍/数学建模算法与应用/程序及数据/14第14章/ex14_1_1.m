clc, clear
x2=@(qujian,lb,ub,x)(1-(qujian(1)-x)./(qujian(1)-lb)).*(x>=lb & x<qujian(1))+...
    (x>=qujian(1) & x<=qujian(2))+(1-(x-qujian(2))./(ub-qujian(2))).*...
    (x>qujian(2) & x<=ub); %定义变换的匿名函数,该语句太长，使用了两个续行符
qujian=[5,6]; lb=2; ub=12; %最优区间，无法容忍下界和上界
x2data=[5 6 7 10 2]'; %x2属性值
y2=x2(qujian,lb,ub,x2data) %调用匿名函数，进行数据变换
