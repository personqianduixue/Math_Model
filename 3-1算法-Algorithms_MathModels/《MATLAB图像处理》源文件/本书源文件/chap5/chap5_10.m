
clear all; close all;
I=imread('onion.png');
figure;
subplot(141);
imshow(uint8(I));
subplot(142);
imhist(I(:,:,1));
title('R');
subplot(143);
imhist(I(:,:,2));
title('G');
subplot(144);
imhist(I(:,:,3));
title('B');