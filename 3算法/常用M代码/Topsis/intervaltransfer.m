function x2 =intervaltransfer(qujian,lb,ub,x)
%TOPSIS法，对区间型变量的规范化处理，qijian表示最优属性区间，lb表示下界，ub表示上界
x2=(1-(qujian(1)-x)./(qujian(1)-lb)).*(x>=lb&x<qujian(1))+(x>=qujian(1)&x<=qujian(2))+(1-(x-qujian(2))./(ub-qujian(2))).*(x>qujian(2)&x<=ub);

end

