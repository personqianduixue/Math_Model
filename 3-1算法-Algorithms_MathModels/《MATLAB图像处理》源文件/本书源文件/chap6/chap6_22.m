

clear all; close all;
I=imread('rice.png');
I=im2double(I);
LEN=30;
THETA=20;
PSF=fspecial('motion', LEN, THETA);
J=imfilter(I, PSF, 'circular', 'conv');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);
K=deconvlucy(J, PSF, 5);
L=deconvlucy(J, PSF, 15);
figure;
subplot(121);  imshow(K);
subplot(122);  imshow(L);

