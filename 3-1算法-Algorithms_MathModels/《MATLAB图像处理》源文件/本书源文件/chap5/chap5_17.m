
clear all; close all;
I=imread('peppers.png');
J=rgb2gray(I);
figure;
subplot(121);
imshow(J);
subplot(122);
imcontour(J,3);