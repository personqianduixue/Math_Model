

clear all; close all;
I=imread('peppers.png');
J=rgb2gray(I);
K=fft2(J);
L=fftshift(K);
fftr=real(L);
ffti=imag(L);
A=sqrt(fftr.^2+ffti.^2);
A=(A-min(min(A)))/(max(max(A))-min(min(A)))*255;
B=angle(K);
figure;
subplot(121);
imshow(A);
subplot(122);
imshow(real(B));


