function re=biaoji(j,biao)  %判断j点是否已被标记
    l=length(biao);
    for i=1:l
       if j==biao(i) 
            re=1;
            return;
       end
    end
    re=0;
    return;
end