
clear all; close all;
I=imread('pout.tif');
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imhist(I);
