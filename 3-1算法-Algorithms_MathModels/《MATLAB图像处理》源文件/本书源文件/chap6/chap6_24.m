
clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
LEN=20;
THETA=20;
PSF=fspecial('motion', LEN, THETA);
J=imfilter(I, PSF, 'circular', 'conv');
INITPSF=ones(size(PSF));
[K, PSF2]=deconvblind(J, INITPSF, 30);
figure;
subplot(121);  imshow(PSF, []);
subplot(122);  imshow(PSF2, []);
axis auto;
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);
