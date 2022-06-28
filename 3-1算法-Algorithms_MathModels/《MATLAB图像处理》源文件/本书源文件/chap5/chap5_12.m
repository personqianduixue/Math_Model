
clear all; close all;
I=imread('tire.tif');
J=histeq(I);
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));
figure;
subplot(121);
imhist(I, 64);
subplot(122);
imhist(J, 64);
