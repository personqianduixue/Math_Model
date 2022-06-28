

clear all; close all;
I=imread('onion.png');
J=rgb2gray(I);
K=fft2(J);
L=fftshift(K);
M=ifft2(K);
figure;
subplot(121);
imshow(uint8(abs(L)/198));
subplot(122);
imshow(uint8(M));

