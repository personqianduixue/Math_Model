function [x,minf]=minconPS(f,g,x0,delta,u,var,eps1,eps2)
%目标函数：f
%约束函数：g
%初始点：x0
%初始步长：delta
%搜索系数：u
%自变量向量：var
%步长精度：eps1
%自变量精度：eps2
%目标函数去最小值时的自变量的值：x
%目标函数的最小值：minf

if nargin==7
    eps2=1.0e-6;
end
n=length(var);
y=x0;
bmainCon=1;

while bmainCon
    yf=Funval(f,var,y);
    yk_1=y;
    for i=1:n
        tmpy=zeros(size(y));
        tmpy(i)=delta(i);
        tmpf=Funval(f,var,y+tmpy);          %正向搜索
        
        for j=1:length(g)
            cong(j)=Funval(g(j),var,y+tmpy);    %计算约束函数的值
        end
        if tmpf<yf&&min(cong)>=0                %搜索到可行点
            bcon=1;
            while bcon
                tmpy(i)=2*tmpy(i);              %加大步长
                tmpf_i=Funval(f,var,y+tmpy);    %计算试探函数值
                
                for j=1:length(g)
                    cong_i(j)=Funval(g(j),var,y+tmpy);  %计算约束函数值
                end
                if tmpf_i<yf&&min(cong_i)>=0
                    y_res=y+tmpy;
                else
                    bcon=0;
                end
            end
        else
            tmpy(i)=delta(i);
            tmpf=Funval(f,var,y-tmpy);                  %负方向搜索
            
            for j=1:length(g)
                cong(j)=Funval(g(j),var,y-tmpy);        %计算约束函数值
            end
            if tmpf<yf&&min(cong)>=0
                bcon=1;
                while bcon
                    tmpy(i)=2*tmpy(i);                  %加大步长
                    tmpf_i= Funval(f,var,y-tmpy);       %计算试探函数值
                    
                    for j=1:length(g)
                        cong_i(j)=Funval(g(j),var,y-tmpy);
                    end
                    if tmpf_i<yf&&min(cong_i)>=0
                        y_res=y-tmpy;
                    else
                        bcon=0;
                    end
                end
            else
                y_res=y;
                delta=delta/u;                          %减小步长
            end
        end
        y=y_y_res;
    end
    if norm(y-yk_1)<=eps2                               %精度判断
        if max(abs(delta))<=eps1
            x=y;
            bmainCon=0;
        else
            delta=delta/u;
        end
    end
end

minf=Funval(f,var,x);