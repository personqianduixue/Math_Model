

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
I=imnoise(I, 'gaussian', 0.05);
PSF=fspecial('average', 3);
J=imfilter(I, PSF);
K=exp(imfilter(log(I), PSF));
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(J);
subplot(133);  imshow(K);

