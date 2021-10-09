

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
I=imnoise(I, 'salt & pepper', 0.1);
domain=[0 1 1 0; 1 1 1 1; 1 1 1 1; 0 1 1 0];
J=ordfilt2(I, 6, domain);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

