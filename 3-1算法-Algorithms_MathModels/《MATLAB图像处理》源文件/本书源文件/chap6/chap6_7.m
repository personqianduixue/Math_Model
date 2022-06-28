


clear all; close all;
I=imread('cameraman.tif');
J=imnoise(I, 'speckle');
K=imnoise(I, 'speckle', 0.2);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);



