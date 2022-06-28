

clear all; close all;
I=imread('rice.png');
I=im2double(I);
PSF=fspecial('gaussian', 8, 4);
J=imfilter(I, PSF, 'conv');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);
v=0.02;
K=imnoise(J, 'gaussian', 0, v);
NP=v*prod(size(I));
L=deconvreg(K, PSF, NP);
figure;
subplot(121);  imshow(K);
subplot(122);  imshow(L);

