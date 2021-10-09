

clear all; close all;
I=imread('cameraman.tif');
I=im2double(I);
[J, thresh]=edge(I, 'prewitt', [], 'both');
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);

