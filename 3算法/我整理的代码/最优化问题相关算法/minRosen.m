function [x,minf]=minRosen(f,A,b,x0,var,eps)
%用到了黄金切割法和进退法
%目标函数：f
%约束矩阵：A
%约束右端向量：b
%初始可行点：x0
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量值：x
%目标函数的最小值：minf

format long
if nargin==5
    eps=1.0e-6;
end

syms l;
x0=transpose(x0);
n=length(var);
sz=size(A);
m=sz(1);

gf=jacobian(f,var);
bConti=1;

while bConti
    k=0;
    s=0;
    A1=A;
    A2=A;
    b1=b;
    b2=b;
    for i=1:m
        dfun=A(i,:)*x0-b(i);
        if abs(dfun)<0.000000001        %对约束条件的系数矩阵和向量做分解
            k=k+1;
            A1(k,:)=A(i,:);             %A1代表等式约束系数矩阵
            b1(k,1)=b(i);               %b1代表等式约束向量
        else
            s=s+1;
            A2(s,:)=A(i,:);              %A2代表不等式约束系数矩阵
            b2(s,1)=b(i);               %b2代表不等式约束系数矩阵
        end
    end
    if k>0
        A1=A1(1:k,:);
        b1=b1(1:k,:);
    end
    if s>0
        A2=A2(1:s,:);
        b2=b2(1:s,:);
    end
    
    while 1
        P=eye(n,n);
        if k>0
            tM=transpose(A1);
            P=P - tM*inv(A1*tM)*A1;
        end
        gv=Funval(gf,var,x0);
        gv=transpose(gv);
        d=-P*gv;                        %d为搜索方向
        if d==0
            if k==0
                x=x0;
                bConti=0;
                break;
            else
                w=inv(A1*tM)*A1*gv;
                if w>=0                 %w分量全为正
                    x=x0;
                    bConti=0;
                    break;
                else
                    [u,index]=min(w);
                    sA1=size(A1);
                    if sA1(1)==1
                        k=0;
                    else
                        k=sA1(2);           %选择w的一个负分量
                        A1=[ A1(1:(index-1),:); A1((index+1):sA1(2),:)];
                            %去掉A1对应的行
                    end
                end
            end
        else
            break;
        end
    end
    
    yl=x0+l*d;
    tmpf=Funval(f,var,yl);
    bb=b2-A2*x0;
    dd=A2*d;
    if dd>=0
        [tmpI,lm]=minJT(tmpf,0,0.1);%用进退法确定一维极值问题的极值区间
    else
        lm=inf;
        for i=1:length(dd)
            if dd(i)<0
                if bb(i)/dd(i)<lm
                   lm=bb(i)/dd(i);
                end
            end
        end
    end
    [xm,minf]=minHJ(tmpf,0,lm,1.0e-14);     %用黄金分割法求解一维极值问题
    tol=norm(xm*d);
    if tol<eps
       x=x0;
       break;
    end
    x0=x0+xm*d;
end
    
minf=Funval(f,var,x);