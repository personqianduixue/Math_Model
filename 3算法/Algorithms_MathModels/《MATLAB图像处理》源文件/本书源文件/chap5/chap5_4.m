
clear all; close all;
I=imread('pout.tif');
J=imadjust(I, [0.1 0.5], [0, 1], 0.4);
K=imadjust(I, [0.1, 0.5], [0, 1], 4);
figure;
subplot(121);
imshow(uint8(J));
subplot(122);
imshow(uint8(K));