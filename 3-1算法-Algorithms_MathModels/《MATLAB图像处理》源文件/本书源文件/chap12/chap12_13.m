

clear all; close all;
I=imread('tire.tif');
J=imfill(I, 'holes');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

