function C=DCT2D(B)
%将图像数据进行快速傅立叶变换，返回幅度和相位信息
a=length(B);
%依次对每一行进行FFT操作
C=zeros(a);
for b=1:a
    C(b,:)=DCT1D(B(b,:));
end
%依次对每一列进行FFT操作
for b=1:a
    T=C(:,b);
    T1=DCT1D(T');
    C(:,b)=T1';
end
