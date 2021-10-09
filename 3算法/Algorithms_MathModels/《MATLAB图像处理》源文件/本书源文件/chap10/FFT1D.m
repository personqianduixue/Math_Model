function B1=FFT1D(A1)
%%－－－对A1中的数据进行奇偶分解排序-----
B=SortOE(A1);
n=length(B);m=log2(n);
for s=1:n
    T(s)=double(B(s));%将图像数据转换为double型
end

for a=0:m-1
    M=2^a;nb=n/M/2;%每一块的半长度和分成的块数
    for j=0:nb-1 %对每一块依次进行操作
        for k=0:M-1%对每一块中的一半的点依次操作
            t1=double(T(1+k+j*2*M));t2=double(T(1+k+j*2*M+M))*exp(-i*pi*k/M);
            T(1+k+j*2*M)=0.5*(t1+t2);
            T(1+k+j*2*M+M)=0.5*(t1-t2);
        end
    end
end
B1=T;
