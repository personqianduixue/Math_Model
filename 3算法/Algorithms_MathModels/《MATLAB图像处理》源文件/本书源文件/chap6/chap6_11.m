

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
I=imnoise(I, 'salt & pepper', 0.01);
PSF=fspecial('average', 3);
Q1=1.6;
Q2=-1.6;
j1=imfilter(I.^(Q1+1), PSF);
j2=imfilter(I.^Q1, PSF);
J=j1./j2;
k1=imfilter(I.^(Q2+1), PSF);
k2=imfilter(I.^Q2, PSF);
K=k1./k2;
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(J);
subplot(133);  imshow(K);

