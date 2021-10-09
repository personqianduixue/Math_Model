y=@(x) x^3-x^2+2*x-3;
x=fsolve(y,rand)  %只能求给定初始值附近的一个零点
