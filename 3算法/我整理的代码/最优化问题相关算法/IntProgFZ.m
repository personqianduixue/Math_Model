function [x,fm]=IntProgFZ(f,A,b,Aeq,beq,lb,ub)
%目标函数系数向量：f
%不等式约束矩阵：A
%不等式约束右端向量：b
%等式约束矩阵：Aeq
%等式约束右端向量：beq
%自变量下界：lb
%自变量上界：ub
%目标函数取最小值时的自变量的值
%目标函数的最小值：minf

x=NaN;
fm=NaN;
NF_lb=zeros(size(lb));
NF_ub=zeros(size(ub));
NF_lb(:,1)=lb;
NF_ub(:,1)=ub;
F=inf;

while 1
    sz=size(NF_lb);
    k=sz(2);
    opt=optimset('TolX',1e-9);
    
    %求解线性规划
    [xm,fv,exitflag]=linprog(f,A,b,Aeq,beq,NF_lb(:,1),NF_ub(:,1),[],opt);
    if exitflag==-2             %不存在最优解
        xm=NaN;
        fv=NaN;
    end
    if xm==NaN
        fv=inf;
    end
    if fv~=inf
        if fv<F
            if max(abs(round(xm)-xm))<1.0e-7    %判断各个分量是否为整数
                F=fv;
                x=xm;
                tmpNF_lb=NF_lb(:,2:k);          %去掉第一列
                tmpNF_ub=NF_ub(:,2:k);          %去掉第一列
                NF_lb=tmpNF_lb;
                NF_ub=tmpNF_ub;
                if isempty(NF_lb)==0
                    continue;
                else
                    if x~=NaN
                        fm=F;
                        return;
                    else
                        disp('不存在最优解！');
                        x=NaN;
                        fm=NaN;
                        return;
                    end
                end
            else
                lb1=NF_lb(:,1);
                ub1=NF_ub(:,1);
                tmpNF_lb=NF_lb(:,2:k);          %去掉第一列
                tmpNF_ub=NF_ub(:,2:k);          %去掉第一列
                NF_lb=tmpNF_lb;
                NF_ub=tmpNF_ub;
                [bArr,index]=find(abs((xm-round(xm)))>1.0e-7);
                %任找一个非整数变量
                p=bArr(1);
                new_lb=lb1;
                new_ub=ub1;
                new_lb(p)=max(floor(xm(p))+1,lb1(p));   %更新求解表
                new_ub(p)=min(floor(xm(p)),ub1(p));     %更新求解表
                NF_lb=[NF_lb new_lb lb1];
                NF_ub=[NF_ub ub1 new_ub];
                continue;
            end
        else                                %fv大于F
            tmpNF_lb=NF_lb(:,2:k);          %去掉第一列
            tmpNF_ub=NF_ub(:,2:k);          %去掉第一列
            NF_lb=tmpNF_lb;
            NF_ub=tmpNF_ub;
            if isempty(NF_lb)==0
                continue;
            else
                if x~=NaN
                    fm=F;
                    return;
                else
                    disp('不存在最优解!');
                    x=NaN;
                    fm=NaN;
                    return;
                end
            end
        end
    else                        %fv为无穷大
        tmpNF_lb=NF_lb(:,2:k);  %去掉第一列
        tmpNF_ub=NF_ub(:,2:k);  %去掉第一列
        NF_lb=tmpNF_lb;
        NF_ub=tmpNF_ub;
        if isempty(NF_lb)==0
            continue;
        else
            if x~=NaN
                fm=F;
                return;
            else
                disp('不存在最优解!');
                x=NaN;
                fm=NaN;
                return;
            end
        end
    end
end
                
            