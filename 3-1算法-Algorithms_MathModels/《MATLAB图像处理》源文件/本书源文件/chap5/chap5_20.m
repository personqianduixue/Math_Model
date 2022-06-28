

clear all; close all;
I=imread('coins.png');
I=im2double(I);
J=imnoise(I, 'salt & pepper', 0.02);
h1=fspecial('average', 3);
h2=fspecial('average', 5);
K1=filter2(h1, J);
K2=filter2(h2, J);
figure;
subplot(131);
imshow(J);
subplot(132);
imshow(K1);
subplot(133);
imshow(K2);