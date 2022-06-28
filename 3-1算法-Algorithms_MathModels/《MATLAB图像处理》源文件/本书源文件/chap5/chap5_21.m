

clear all; close all;
I=imread('coins.png');
I=im2double(I);
J=imnoise(I, 'salt & pepper', 0.03);
K=medfilt2(J);
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J);
subplot(133);
imshow(K);