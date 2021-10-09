clc,clear;
load q2; % 导入计算好的精避障照片网格信息
load yf2;% 导入原始精避障照片信息
for p=1:20
    for q=1:20
        E=zeros(50,50);
        if q2(p,q)~=-1
            for i=2:49
                for j=2:49
                    a=50*(p-1)+i;
                    b=50*(q-1)+j;
                    E(i,j)=(yf2(a-1,b-1)-yf2(a,b))^2+(yf2(a-1,b)-yf2(a,b))^2+...
                        (yf2(a-1,b+1)-yf2(a,b))^2+(yf2(a,b-1)-yf2(a,b))^2+...
                        (yf2(a,b+1)-yf2(a,b))^2+(yf2(a+1,b-1)-yf2(a,b))^2+...
                        (yf2(a+1,b)-yf2(a,b))^2+(yf2(a+1,b+1)-yf2(a,b))^2;
                end
            end
            w(p,q)=sum(sum(E(i,j)));    
        end
    end
end
