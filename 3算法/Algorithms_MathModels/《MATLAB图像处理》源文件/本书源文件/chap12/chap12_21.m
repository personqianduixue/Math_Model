

clear all; close all;
I=imread('circles.png');
J=bwmorph(I, 'remove');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

