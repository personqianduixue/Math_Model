

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
J=imnoise(I, 'salt & pepper', 0.01);
K=imnoise(I, 'salt & pepper', 0.03);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

