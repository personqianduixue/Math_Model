

clear all; close all;
I=imread('text.png');
J=bwmorph(I, 'thin', Inf);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);