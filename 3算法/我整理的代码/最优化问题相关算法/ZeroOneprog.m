function [intx,intf]=ZeroOneprog(c,A,b,x0)
%目标函数系数向量：c
%不等式约束矩阵：A
%不等式约束右端向量：b
%初始整数可行解：x0
%目标函数取最小值时的自变量值：intx；
%目标函数的最小值：intf

sz=size(A);
if sz(2)<3
    [intx,intf]=Allprog(c,A,b);     %穷举法
else
    [intx,intf]=Implicitprog(c,A,b,x0);  %隐枚举法
end

function [intx,inf]=Allprog(c,A,b)
sz_A=size(A);
rw=sz_A(1);
col=sz_A(2);

minf=inf;
for i=0:(2^(col)-1)             %枚举空间
    x1=myDec2Bin(i,col);        %十进制转换为二进制
    if A*x1>=b                  %是否满足约束条件
        f_tmp=c*x1;
        if f_tmp<minf
            minf=f_tmp;
            intx=x1;
            intf=minf;
        else
            continue;
        end
    else
        continue;
    end
end

function [intx,intf]=Implicitprog(c,A,b,x0)         %隐枚举法
sz_A=size(A);
rw=sz_A(1);
col=sz_A(2);

minf=c*x0;
A=[A;-c];
b=[b;-minf];                            %增加了一个限制分量
for i=0:(2^(col)-1)
    x1=myDec2Bin(i,col);
    if A*x1>=b
        f_tmp=c*x1;
        if f_tmp<minf
            minf=f_tmp;
            b(rw+1,1)=-minf;            %隐枚举法与穷举法的区别在词句
            intx=x1;
            intf=minf;
        else
            continue;
        end
    else
        continue;
    end
end

function y=myDec2Bin(x,n)               %十进制转换为二进制
str=dec2bin(x,n);
for j=1:n
    y(j)=str2num(str(j));
end
y=transpose(y);
       