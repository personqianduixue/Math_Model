function y=ycfun1(x);   %x为行向量
c1=[2 3 1]; c2=[3 1 0];
y= c1* x' + c2* x'.^2; y=-y;
