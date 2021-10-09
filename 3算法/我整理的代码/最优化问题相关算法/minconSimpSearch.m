function [x,minf]=minconSimpSearch(f,g,X,alpha,sita,gama,beta,var,eps)
%目标函数：f
%约束函数：g
%初始复合形：X
%反射系数：alpha
%紧缩系数：sita
%扩展系数：gama
%搜索系数：beta
%自变量向量：var
%自变量精度：eps
%目标函数取最小值时的自变量值：x
%目标函数的最小值：minf

if nargin==8
    eps=1.0e-6;
end

N=size(X);
n=N(2);
FX=zeros(1,n);

while 1
    for i=1:n
        FX(i)=Funval(f,var,X(:,i));
    end
    [XS,IX]=sort(FX);                   %将复合形的顶点排序
    Xsorted=X(:,IX);
    
    px=sum(Xsorted(:,1:(n-1)),2)/(n-1);     %复合形前n个点的中心
    Fpx=Funval(f,var,px);
    SumF=0;
    for i=1:n
        SumF=SumF+(FX(IX(i))-Fpx)^2;
    end
    SumF=sqrt(SumF/n);
    if SumF<=eps
        x=Xsorted(:,1);
        break;
    else
        bcon_1=1;
        cof_alpha=alpha;
        while bcon_1
            x2=px+cof_alpha*(px-Xsorted(:,n));  %反射操作
            gx2=Funval(g,var,x2);
            if min(gx2)>=0
                bcon_1=0;
            else
                cof_alpha=sqrt(cof_alpha);      %以开方的方式减少反射系数
            end
        end
        fx2=Funval(f,var,x2);
        if fx2<XS(1)
            cof_gama=gama;
            bcon_2=1;
            while bcon_2
                x3=px+cof_gama*(x2-px);         %扩展操作
                gx3=Funval(g,var,x3);
                if min(gx3)>=0
                    bcon_2=0;
                else
                    cof_gama=sqrt(cof_gama);        %以开方的方式减少扩展系数
                end
            end
            fx3=Funval(f,var,x3);
            if fx3<XS(1)
                Xsorted(:,n)=x3;
                X=Xsorted;
                continue;
            else
                Xsorted(:,n)=x2;
                X=Xsorted;
                continue;
            end
        else
            if fx2<XS(n-1)
                Xsorted(:,n)=x2;
                X=Xsorted;
                continue;
            else
                if fx2<XS(n)
                    Xsorted(:,n)=x2;
                end
                
                cof_beta=beta;
                bcon_3=1;
                while bcon_3
                    x4=px+cof_beta*(Xsorted(:,n)-px);   %收缩操作
                    gx4=Funval(g,var,x4);
                    if min(gx4)>=0
                        bcon_3=0;
                    else
                        cof_beta=cof_beta/2;            %减少收缩系数
                    end
                end
                fx4=Funval(f,var,x4);
                FNnew=Funval(f,var,Xsorted(:,n));
                if fx4<FNnew
                    Xsorted(:,n)=x4;
                    X=Xsorted;
                    continue;
                else
                    x0=Xsorted(:,1);
                    for i=1:n
                        Xsorted(:,j)=x0+sita*(Xsorted(:,j)-x0); %对复合形进行紧缩
                    end
                end
            end
        end
    end
    X=Xsorted;
end
minf=Funval(f,var,x);
    