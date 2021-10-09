

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
PSF=fspecial('gaussian', 7, 10);
v=0.0001;
J=imnoise(imfilter(I, PSF), 'gaussian',0, v);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);
WT=zeros(size(I));
WT(5:end-4, 5:end-4)=1;
K=deconvlucy(J, PSF, 20, sqrt(v));
L=deconvlucy(J, PSF, 20, sqrt(v), WT);
figure;
subplot(121);  imshow(K);
subplot(122);  imshow(L);

