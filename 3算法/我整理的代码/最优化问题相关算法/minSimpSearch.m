function [x,minf]=minSimpSearch(f,X,alpha,sita,gama,beta,var,eps)
%目标函数：f
%初始单纯形：X
%反映系数：alpha
%紧缩系数：sita
%扩展系数：gama
%收缩系数：beta
%自变量向量：var
%精度：eps
%目标函数取最小值时的自变量：x
%目标函数的最小值：minf
format long;
if nargin==7
    eps=1.0e-6;
end

N=size(X);
n=N(2);
FX=zeros(1,n);

while 1
    for i=1:n
        FX(i)=Funval(f,var,X(:,i));
    end
    [XS,IX]=sort(FX);                                    %将单纯形的顶点按照目标函数值的大小重新编号
    Xsorted=X(:,IX);                                     %排序后的编号
    
    px=sum(Xsorted(:,1:(n-1)),2)/(n-1);                  %单纯形的中心
    Fpx=Funval(f,var,px);
    SumF=0;
    for i=i:n
        SumF=SumF+(FX(IX(i))-Fpx)^2;
    end
    SumF=sqrt(SumF/n);
    if SumF<=eps                                         %精度判断
        x=Xsorted(:,1);
        break;
    else
        x2=px+alpha*(px-Xsorted(:,n));                    %将中心点移到单纯形的外反射
        fx2=Funval(f,var.x2);
        if fx2<XS(1)
           x3=px+gama*(x2-px);                     %中心点的扩展
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
              x4=px+beta*(Xsorted(:,n)-px);       %中心点的压缩
              fx4=Funval(f,var,x4);
              FNnew=Funval(f,var,Xsorted(:,n));
              if fx4<FNnew
                 Xsorted(:,n)=x4;
                 X=Xsorted;
                 continue;
              else
                 x0=Xsorted(:,1);
                 for i=1:n
                     Xsorted(:,i)=x0+sita*(Xsorted(:,i)-x0);
                 end
              end
           end
        end
     end
     X=Xsorted;
end
minf=Funval(f,var,x);
format short;
              