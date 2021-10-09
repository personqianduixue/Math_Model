function f=fun1(canshu,xdata);
f= exp(-canshu(1)*xdata(:,1)).*sin(canshu(2)*xdata(:,2))+xdata(:,3).^2;  %其中canshu(1)=k1，canshu(2)=k2，注意函数中自变量的形式
