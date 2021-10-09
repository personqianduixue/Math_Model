

clear all; close all;
I=imread('circbw.tif');
J=bwperim(I, 8);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

