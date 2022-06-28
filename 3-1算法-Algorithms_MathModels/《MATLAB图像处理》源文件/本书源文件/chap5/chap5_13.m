

clear all; close all;
I=imread('tire.tif');
hgram=ones(1, 256);
J=histeq(I, hgram);
figure;
subplot(121);
imshow(uint8(J));
subplot(122);
imhist(J);
