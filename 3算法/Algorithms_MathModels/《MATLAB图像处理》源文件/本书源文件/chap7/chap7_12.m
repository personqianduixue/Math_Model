

clear all; close all;
I=imread('coins.png');
I=im2double(I);
T=graythresh(I);
J=im2bw(I, T);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

