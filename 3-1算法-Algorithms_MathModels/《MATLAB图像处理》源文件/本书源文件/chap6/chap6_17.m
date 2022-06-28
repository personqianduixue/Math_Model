

clear all; close all;
I=imread('onion.png');
I=rgb2gray(I);
I=im2double(I);
LEN=25;
THETA=20;
PSF=fspecial('motion', LEN, THETA);
J=imfilter(I, PSF, 'conv', 'circular');
NSR=0;
K=deconvwnr(J, PSF, NSR);
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(J);
subplot(133);  imshow(K);



