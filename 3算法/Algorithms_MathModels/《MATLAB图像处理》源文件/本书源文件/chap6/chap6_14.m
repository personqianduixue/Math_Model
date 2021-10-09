

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
I=imnoise(I, 'salt & pepper', 0.01);
J=ordfilt2(I, 1, ones(4,4));
K=ordfilt2(I, 9, ones(3));
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

