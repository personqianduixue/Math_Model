
clear all; close all;
I=imread('coins.png');
J=imnoise(I, 'salt & pepper', 0.02);
h=ones(3,3)/5;
h(1,1)=0;   h(1,3)=0;
h(3,1)=0;   h(1,3)=0;
K=imfilter(J, h);
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J);
subplot(133);
imshow(K);