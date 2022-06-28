


clear all; close all;
I=imread('football.jpg');
J=rgb2hsv(I);
h=figure;
set(h, 'position', [200, 200, 1000, 400]);
subplot(141);
imshow(uint8(I));
subplot(142);
imhist(J(:,:,1));
title('H');
subplot(143);
imhist(J(:,:,2));
title('S');
subplot(144);
imhist(J(:,:,3));
title('V');

