function B=DCT1D(A)
%一维离散余弦变换
n=length(A);
%对变换数组延拓
T=zeros(1,n);
C=[A,T];
C=FFT1D(C)*2*n;
T=C(1:n);
T(1)=T(1)/n^0.5;
for u=2:n
    T(u)=(2/n)^0.5*T(u)*exp(-i*(u-1)*pi/2/n);
end
B=real(T);
