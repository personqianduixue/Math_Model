

clear all; close all;
I=checkerboard(8);
PSF=fspecial('gaussian', 7, 10);
v=0.001;
J=imnoise(imfilter(I, PSF), 'gaussian', 0, v);
INITPSF=ones(size(PSF));
WT=zeros(size(I));
WT(5:end-4, 5:end-4)=1;
[K, PSF2]=deconvblind(J, INITPSF, 20, 10*sqrt(v), WT);
figure;
subplot(131);  imshow(I);
subplot(132);  imshow(J);
subplot(133);  imshow(K);

