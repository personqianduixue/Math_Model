function y=ave(data)  %对数据按站号进行分组并求平均值
    k=data(1,1) 
    count=0;
    sumd=0;
    j=1;
    x=size(data);
    for i=1:x
        if data(i,1)==k
            count=count+1;%记数
            sumd=sumd+data(i,2);
        else k=data(i,1);
            y(j)=sumd/count;   %求均值
            sumd=0;             %还原以待下一组数据
            count=0;   
            j=j+1;
        end   
    end
   y(j)=sumd/count;
end

        