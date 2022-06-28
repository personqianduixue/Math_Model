

clear all; close all;
I=imread('pout.tif');
J=medfilt2(I);
r=corr2(I, J)
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(J);