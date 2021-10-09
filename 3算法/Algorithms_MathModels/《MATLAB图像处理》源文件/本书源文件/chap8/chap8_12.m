

clear all; close all;
I=imread('peppers.png');
J=rgb2gray(I);
J=imnoise(J, 'gaussian', 0, 0.01);
K=fft2(J);
K=fftshift(K);
L=abs(K/256);
figure;
subplot(121);
imshow(J);
subplot(122);
imshow(uint8(L));

