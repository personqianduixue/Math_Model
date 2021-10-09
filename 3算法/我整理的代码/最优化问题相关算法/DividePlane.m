function [intx,intf]=DividePlane(A,c,b,baseVector)
%约束矩阵：A；
%目标函数系数向量：c；
%约束右端向量：b；
%初始基向量：baseVector
%目标函数取最小值时的自变量值：x；
%目标函数的最小值：minf

%注意对于目标函数的系数向量大于0的情况，本程序是会出错的


sz=size(A);
nVia=sz(2);
n=sz(1);
xx=1:nVia;

if length(baseVector)~=n
    disp('基变量的个数要与约束矩阵的行数相等！');
    mx=NaN;
    mf=NaN;
    return;
end

M=0;
sigma=-[transpose(c) zeros(1,(nVia-length(c)))];
xb=b;

while 1
    %首先用单纯形法求解出最优解，以下的程序过程可参考线性规划的单纯型法程序
    [maxs,ind]=max(sigma);
    if maxs<=0                          %用单纯形法找到最优解
        vr=find(c~=0,1,'last');
        for l=1:vr
            ele=find(baseVector==l,1);
            if(isempty(ele))
                mx(l)=0;
            else
                mx(l)=xb(ele);
            end
        end
        if max(abs(round(mx)-mx))<1.0e-7    %判断最优解是否为整数
            intx=mx;
            intf=mx*c;
            return;
        else
            sz=size(A);
            sr=sz(1);
            sc=sz(2);
            [max_x,index_x]=max(abs(round(mx)-mx));
            [isB,num]=find(index_x==baseVector);
            fi=xb(num)-floor(xb(num));
            for i=1:(index_x-1)
                Atmp(1,i)=A(num,i)-floor(A(num,i));
            end
            for i=(index_x+1):sc
                Atmp(1,i)=A(num,i)-floor(A(num,i));
            end
            
            
            %以下程序语句构建对偶单纯形法的初始表格
            Atmp(1,index_x)=0;
            A=[A zeros(sr,1);-Atmp(1,:) 1];
            xb=[xb;-fi];
            baseVector=[baseVector sc+1];
            sigma=[sigma 0];
            
            %对偶单纯形法的迭代过程
            while 1
                if xb>=0
                    if max(abs(round(xb)-xb))<1.0e-7
                        %用对偶单纯形法求得了整数解
                        vr=find(c~=0,1,'last');
                        for l=1:vr
                            ele=find(baseVector==l,1);
                            if(isempty(ele))
                                mx_l(1)=0;
                            else
                                mx_l(1)=xb(ele);
                            end
                        end
                        intx=mx_1;
                        intf=mx_1*c;
                        return;
                    else            %最优解不是整数解，继续添加切割方程
                        sz=size(A);
                        sr=sz(1);
                        sc=sz(2);
                        [max_x,index_x]=max(abs(round(mx_1)-mx_1));
                        [isB,num]=find(index_x==baseVector);
                        fi=xb(num)-floor(xb(num));
                        for i=1:(index_x-1)
                            Atmp(1,i)=A(num,i)-floor(A(num,i));
                        end
                        for i=(index_x+1):sc
                            Atmp(1,i)=A(num,i)-floor(A(num,i));
                        end
                        
                        %以下语句是对下一次单纯形迭代的初始表格
                        Atmp(1,index_x)=0;
                        A=[A zeros(sr,1);-Atmp(1,:) 1];
                        xb=[xb;-fi];
                        baseVector=[baseVector sc+1];
                        sigma=[sigma 0];
                        continue;
                    end
                else
                    minb_1=inf;
                    chagB_1=inf;
                    sA=aize(A);
                    [br,idb]=min(xb);
                    for j=1:sA(2)
                        if A(idb,j)<0
                            bm=sigma(j)/A(idb,j);
                            if bm<minb_1
                                minb_1=bm;
                                chagB_1=j;
                            end
                        end
                    end
                    sigma=sigma-A(idb,:)*minb_1;
                    xb(idb)=xb(idb)/A(idb,chagB_1);
                    A(idb,:)=A(idb,:)/A(idb,chagB_1);
                    for i=1:sA(1)
                        if i~=idb
                            xb(i)=xb(i)-A(i,chagB_1)*xb(idb);
                            A(i,:)=A(i,:)-A(i,chagB_1)*A(idb,:);
                        end
                    end
                    baseVector(idb)=chagB_1;
                end
            end
        end
    else
        %以下为单纯形法的迭代过程
        minb=inf;
        chagB=inf;
        for j=1:n
            if A(j,ind)>0
                bz=xb(j)/A(j,ind);
                if bz<minb
                    minb=bz;
                    chagB=j;
                end
            end
        end
        sigma=sigma-A(chagB,:)*maxs/A(chagB,ind);
        xb(chagB)=xb(chagB)/A(chagB,ind);
        A(chagB,:)=A(chagB,:)/A(chagB,ind);
        for i=1:n
            if i~=chagB
                xb(i)=xb(i)-A(i,ind)*xb(chagB);
                A(i,:)=A(i,:)-A(i,ind)*A(chagB,:);
            end
        end
        baseVector(chagB)=ind;
    end
    M=M+1;
    if(M==1000000)
        disp('找不到最优解');
        mx=NaN;
        minf=NaN;
        return;
    end
end