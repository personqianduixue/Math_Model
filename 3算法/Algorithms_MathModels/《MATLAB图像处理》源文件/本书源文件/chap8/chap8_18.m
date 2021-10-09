

clear all; close all;
I=imread('cameraman.tif');  
I=im2double(I);  		
J=fftshift(fft2(I));    
[x, y]=meshgrid(-128:127, -128:127);
z=sqrt(x.^2+y.^2);
D1=10;  D2=40;
n1=4;  n2=8;
H1=1./(1+(D1./z).^(2*n1));
H2=1./(1+(D2./z).^(2*n2));
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

