

clear all; close all;
I=imread('rice.png');
I=im2double(I);
LEN=20;
THETA=10;
PSF=fspecial('motion', LEN, THETA);
J=imfilter(I, PSF, 'conv', 'circular');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);
noise=0.03*randn(size(I));
K=imadd(J, noise);
NP=abs(fft2(noise)).^2;
NPower=sum(NP(:))/prod(size(noise));
NCORR=fftshift(real(ifft2(NP)));
IP=abs(fft2(I)).^2;
IPower=sum(IP(:))/prod(size(I));
ICORR=fftshift(real(ifft2(IP)));
L=deconvwnr(K, PSF, NCORR, ICORR);
figure;
subplot(121);  imshow(K);
subplot(122);  imshow(L);

