

clear all; close all;
I=imread('coins.png');
I=im2double(I);
J=imnoise(I, 'gaussian', 0, 0.01);
K=wiener2(J, [5 5]);
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J);
subplot(133);
imshow(K);

