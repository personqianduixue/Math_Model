function K=julei(B)%%%K 类 和具体编号

[m,n]=size(B);

C=sortrows(B,2);

K={};
t=1;
K{t,2}=[];
for i=1:m-1
    if C(i,3)<=C(i+1,2)
    K{t,1}=[C(i,2),C(i,3)];
    K{t,2}=[K{t,2},C(i,1)];
    t=t+1;
    K{t,2}=[];
    else 
        C(i+1,3)=min(C(i,3),C(i+1,3));
        K{t,1}=[C(i+1,2),C(i,3)];
        K{t,2}=[K{t,2},C(i,1)];
    end
end
K{t,2}=[K{t,2},C(m,1)];
        