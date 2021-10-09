

clear all; close all;
I=imread('coins.png');  
I=im2double(I);  		
M=2*size(I,1);
N=2*size(I,2);
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u, v);
D=sqrt(U.^2+V.^2);
D0=20;
H=1-exp(-(D.^2)./(2*(D0^2)));
J=fftshift(fft2(I, size(H, 1), size(H, 2))); 
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(I,1), 1:size(I, 2));
figure;
subplot(121);
imshow(I);
subplot(122);
imshow(L);

