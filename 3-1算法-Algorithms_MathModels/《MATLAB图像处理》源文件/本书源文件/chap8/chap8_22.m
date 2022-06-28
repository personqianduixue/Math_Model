

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
J=dct2(I);
J(abs(J)<0.1)=0;
K=idct2(J);
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J);
subplot(133);
imshow(K);