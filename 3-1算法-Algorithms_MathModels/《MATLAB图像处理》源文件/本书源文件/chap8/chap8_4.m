

clear all; close all;
I=imread('circuit.tif');
theta=0:2:179;
[R, xp]=radon(I, theta);
J=iradon(R, theta);
figure;
subplot(131);
imshow(uint8(I));
subplot(132);
imagesc(theta, xp, R);
axis normal;
subplot(133);
imshow(uint8(J));
