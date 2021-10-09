function [xv,fv]=ActivdeSet(H,c,A,b,x0,AcSet)
%正定矩阵：H
%二次规划一次项系数向量：c
%不等式约束系数矩阵：A
%不等式约束右端向量：b
%初始点：x0
%初始约束指标集：AcSet
%目标函数取最小值时的自变量值：xv
%目标函数的最小值：fv


sz=size(A);
xx=1:sz(1);
nonAcSet=zeros(1,1);
m=1;

for i=1:sz(1)           %寻找非约束指标集
    if(isempty(find(AcSet==xx(i),1)))
        nonAcSet(m)=i;
        m=m+1;
    else
        ;
    end
end

invH=inv(H);
bCon=1;
while bCon
    cl=H*x0+c;
    Al=A(AcSet,:)
    bl=b(AcSet);
    xm=QuadLagR(H,cl,Al,zeros(length(AcSet),1));    %用拉格朗日法求解由约束指标集定义的等式约束二次规划
    
    if xm==0        %最优解为0
        trAl=transpose(Al);
        R=inv(Al*invH*trAl)*Al*invH;
        lamda=R*(H*xm+cl);              %拉格朗日乘子
        [lmin,index]=min(lamda);        %拉格朗日乘子的最小值
        if lmin>=0
            xv=x0;                      %停止计算，得出最优解
            fv=transpose(x0)*H*x0/2+transpose(c)*x0;
            bCon=0;
            return;
        else
            l=length(AcSet);            %删除指标AcSet(index)
            nonAcSet=[nonAcSet AcSet(index)];
            [sa,sb]=sort(nonAcSet);
            nonAcSet=sa;
            tmpAcS=[AcSet(1:(index-1))  AcSet((index+1):1)];
            AcSet=tmpAcS;
        end
    else
        d=xm;
        mAlpha=inf;
        adinAcS=0;
        for i=1:length(nonAcSet)        %确定alpha
            if A(nonAcSet(i),:)*d<0
                alpha=(b(nonAcSet(i))-A(nonAcSet(i),:)*x0)/(A(nonAcSet(i),:)*d);
                if alpha<mAlpha
                    mAlpha=alpha;
                    adinAcS=nonAcSet(i);
                end
            end
        end
        mXA=min(1,mAlpha);              %确定alpha-k
        x0=x0+mXA*d;
        if mXA<1
            AcSet=[AcSet adinAcS];      %将adinAcS加入约束指标集
            [sa,sb]=sort(AcSet);
            AcSet=sa;
        else                            %以下同xm==0的情况
            cl=H*x0+c;
            Al=A(AcSet,:);
            bl=b(AcSet);
            trAl=transpose(Al);
            R=inv(Al*invH*trAl)*Al*invH;
            lamda=R*(H*xm+cl);
            [lmin,index]=min(lamda);
            if lmin>=0
                xv=x0;
                fv=transpose(x0)*H*x0/2+transpose(c)*x0;
                bCon=0;
                return;
            else
                l=length(AcSet);
                nonAcSet=[nonAcSet AcSet(index)];
                [sa,sb]=sort(nonAcSet);
                nonAcSet=sa;
                tmpAcS=[AcSet(1:(index-1)) AcSet((index+1):1)];
                AcSet=tmpAcS;
            end
        end
    end
end