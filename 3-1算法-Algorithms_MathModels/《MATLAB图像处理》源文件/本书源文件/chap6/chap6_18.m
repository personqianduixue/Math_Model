

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
LEN=21;
THETA=11;
PSF=fspecial('motion', LEN, THETA);
J=imfilter(I, PSF, 'conv', 'circular');
noise_mean=0;
noise_var=0.0001;
K=imnoise(J, 'gaussian', noise_mean, noise_var);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(K);
NSR1=0;
L1=deconvwnr(K, PSF, NSR1);
NSR2=noise_var/var(I(:));
L2=deconvwnr(K, PSF, NSR2);
figure;
subplot(121);  imshow(L1);
subplot(122);  imshow(L2);
