function A=qujian(B) %%%%%求每一个药品的容许列区间

[m,n]=size(B);
for i=1:m
    k=B(i,4); %%%宽
    c=B(i,2); %%%长
    g=B(i,3); %%%高
    dkg=sqrt(k^2+g^2); %%%宽高对角线
    dck=sqrt(c^2+k^2); %%%宽长对角线
    A(i,1)=B(i,1); %%编号
    A(i,2)=k+2;%%下限
    A(i,3)=min([2*k,dkg,dck]);%%上限
end
    