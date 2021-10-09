

clear all; close all;
I=imread('cameraman.tif');
J=fft2(I);
K=abs(J/256);
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(uint8(K));

