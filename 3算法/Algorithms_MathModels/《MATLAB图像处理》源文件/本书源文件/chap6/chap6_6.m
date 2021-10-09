

clear all; close all;
I=imread('cameraman.tif');
J=imnoise(I, 'poisson');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

