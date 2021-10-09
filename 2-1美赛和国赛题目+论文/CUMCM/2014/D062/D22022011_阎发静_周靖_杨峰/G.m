l=data(:,1);  %药盒规格长度
h=data(:,2);  %药盒规格高度
k=data(:,3);  %药盒规格宽度
for i=1:1919
    h(i)=h(i)+2;  %药盒所需槽高度最小值
    k(i)=k(i)+2;  %药盒所需槽宽度最大值
end
g1=[35 41 47 53 59 65 71 77 83 89 95 113 127];
s1=[ 17 19 23 27 30 34 37 40 43 46 49 58];
for i=1:1919     
    for j=1:12
        if k(i)>s1(j)
            j=j+1;
        
        else
            k1(i)=s1(j);
            breas;
        end
    end
end
for i=1:1919     
    for j=1:11
        if h(i)>g1(j)
            j=j+1;
      
        else
            h1(i)=g1(j);
            breas; 
        end
    end
end
for i=1:1919
        s(i)=k1(i)*h1(i);  
end
a=0;
for i=1:1919              %求出每天最大需求量下，所有药槽所占的面积
    ys(i)=cs(i)*s(i);
    a=a+ys(i);
end
s=fix(a/3000000)+1;      %储药柜的数量
b1=a/3000000;


