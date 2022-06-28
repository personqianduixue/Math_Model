

clear all; close all;
I=imread('circbw.tif');
J=bwmorph(I, 'skel', Inf);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

