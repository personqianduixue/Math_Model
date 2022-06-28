
clear all; close all;
I=imread('pout.tif');
M=stretchlim(I);
J=imadjust(I, M, [ ]);
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));