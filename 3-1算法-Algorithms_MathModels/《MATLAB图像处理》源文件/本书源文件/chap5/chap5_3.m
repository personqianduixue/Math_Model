
clear all; close all;
I=imread('pout.tif');
J=imadjust(I, [0.2 0.5], [0 1]);
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));