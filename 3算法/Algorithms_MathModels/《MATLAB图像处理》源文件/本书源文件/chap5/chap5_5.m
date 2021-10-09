
clear all; close all;
I=imread('football.jpg');
J=imadjust(I, [0.2 0.3 0; 0.6 0.7 1], []);
figure;
subplot(121);
imshow(uint8(I));
subplot(122);
imshow(uint8(J));