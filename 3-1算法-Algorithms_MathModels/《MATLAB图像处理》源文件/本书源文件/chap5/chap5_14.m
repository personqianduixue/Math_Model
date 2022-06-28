
clear all; close all;
I=imread('onion.png');
J=rgb2gray(I);
gray=mean2(J)
rgb=mean2(I)
r=mean2(I(:, :, 1))
g=mean2(I(:, :, 2))
b=mean2(I(:, :, 3))
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));

