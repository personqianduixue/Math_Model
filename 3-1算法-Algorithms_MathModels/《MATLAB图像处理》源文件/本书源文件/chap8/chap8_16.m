

clear all; close all;
I=imread('text.png');
a=I(32:45, 88:98);
figure;
imshow(I);
figure;
imshow(a);
c=real(ifft2(fft2(I).*fft2(rot90(a, 2), 256, 256)));
figure;
imshow(c, []);
max(c(:))
thresh=60;
figure;
imshow(c>thresh)

