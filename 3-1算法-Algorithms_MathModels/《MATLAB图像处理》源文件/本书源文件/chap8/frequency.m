

clear all; close all;
I=imread('cameraman.tif');  
I=im2double(I);  		
J=fftshift(fft2(I));    
[x, y]=meshgrid(-128:127, -128:127);
[M, N]=size(I);
n1=floor(M/2);
n2=floor(N/2);
z=sqrt((x-n1).^2+(y-n2).^2);
D1=10;  D2=30;
n=6;
H1=1./(1+(z/D1).^(2*n));
H2=1./(1+(z/D2).^(2*n));
K1=J.*H1;
K2=J.*H2;
L1=ifft2(ifftshift(K1));
L2=ifft2(ifftshift(K2));
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(real(L1));
subplot(133);
imshow(real(L2))


