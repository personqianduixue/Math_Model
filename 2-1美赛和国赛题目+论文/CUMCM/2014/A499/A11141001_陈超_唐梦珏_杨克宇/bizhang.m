% ±ÜÕÏÓÅ»¯
clc,clear all
load('pingdif4.mat');
% ´Ö±ÜÕÏ
x=5:10:2295;
y=5:10:2295;
q=zeros(230,230);
qu=zeros(10,10);
f1=double(f1);
for i=1:230
    for j=1:230
        qu=f1((x(i)-4):(x(i)+5),(y(j)-4):(y(j)+5));
        count=0;
        fls=[];
        for k=1:10
            for l=1:10
                if qu(k,l)==0
                    count=count+1;
                else
                    fls=[fls,qu(k,l)];
                end
            end
        end
        if count>20
            q(i,j)=-1;
        else
            q(i,j)=var(fls);
        end
    end
end
save('q1','q');
