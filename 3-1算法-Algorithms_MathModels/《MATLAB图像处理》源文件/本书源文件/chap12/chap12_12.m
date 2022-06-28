

clear all; close all;
I=imread('coins.png');
J=im2bw(I);
K=imfill(J, 'holes');
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

