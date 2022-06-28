
clear all; close all;
I=imread('rice.png');
I=im2double(I);
J=imnoise(I, 'gaussian', 0, 0.01);
h=ones(3,3)/9;
K=conv2(J, h);
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J);
subplot(133);
imshow(K);