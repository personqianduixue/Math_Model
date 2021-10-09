

clear all; close all;
I=imread('rice.png');
I=im2double(I);
PSF=fspecial('gaussian', 10, 5);
J=imfilter(I, PSF, 'conv');
v=0.02;
K=imnoise(J, 'gaussian', 0, v);
NP=v*prod(size(I));
[L, LAGRA]=deconvreg(K, PSF, NP);
edged=edgetaper(K, PSF);
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(K);
subplot(133);  imshow(edged);
M1=deconvreg(edged, PSF, [], LAGRA);
M2=deconvreg(edged, PSF, [], LAGRA*30);
M3=deconvreg(edged, PSF, [], LAGRA/30);
figure;
subplot(131);  imshow(M1);
subplot(132);  imshow(M2);
subplot(133);  imshow(M3);

