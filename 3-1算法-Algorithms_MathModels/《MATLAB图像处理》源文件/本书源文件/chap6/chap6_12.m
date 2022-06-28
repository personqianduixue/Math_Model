

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
I=imnoise(I, 'salt & pepper', 0.05);
J=medfilt2(I, [3, 3]);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);


