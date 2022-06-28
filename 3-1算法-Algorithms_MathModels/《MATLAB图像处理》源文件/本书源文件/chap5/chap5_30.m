

clear all; close all;
I=imread('pout.tif');
J=log(im2double(I)+1);	
K=fft2(J);
n=5;
D0=0.1*pi;
rh=0.7;
rl=0.4;
[row, column]=size(J);
for i=1:row
    for j=1:column
        D1(i,j)=sqrt(i^2+j^2);
        H(i,j)=rl+(rh/(1+(D0/D1(i,j))^(2*n)));
    end
end
L=K.*H;
M=ifft2(L);
N=exp(M)-1;
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(real(N));

