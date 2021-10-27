function y=val(p,q)  %计算各组数据和
    [a,b]=size(p);
    for i=1:a
        y(i)=polyval(p(i,:),q(i));
    end