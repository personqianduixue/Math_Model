

clear all; close all;
I=imread('coins.png');
I=im2double(I);
J=dct2(I);
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(log(abs(J)), []);

