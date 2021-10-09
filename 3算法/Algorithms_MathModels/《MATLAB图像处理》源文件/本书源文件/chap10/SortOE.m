%奇偶分解排序函数
function  B=SortOE(T)
    n=length(T);m=log2(n/2);
for i=1:m
    nb=2^i;lb=n/nb;%分成的块数和每一块的长度
    lc=2*lb;%操作间隔
        for j=0:nb/2-1   %进行排序操作的次数
            t=T(2+j*lc:2:2*lb+j*lc);
            T(1+j*lc:lb+j*lc)=T(1+j*lc:2:(2*lb-1)+j*lc);
            T(lb+1+j*lc:2*lb+j*lc)=t;
        end
 end
B=T;
