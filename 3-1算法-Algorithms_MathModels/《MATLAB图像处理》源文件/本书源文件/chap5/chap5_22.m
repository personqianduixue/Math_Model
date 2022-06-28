

clear all; close all;
I=imread('coins.png');
I=im2double(I);
J1=ordfilt2(I, 1, true(5));
J2=ordfilt2(I, 25, true(5));
figure;
subplot(131);
imshow(I);
subplot(132);
imshow(J1);
subplot(133);
imshow(J2);

