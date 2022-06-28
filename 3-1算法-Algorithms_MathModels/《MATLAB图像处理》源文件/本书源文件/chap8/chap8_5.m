
clear all; close all;
I=phantom(256);
figure;
imshow(I);
theta1=0:10:170;
theta2=0:5:175;
theta3=0:2:178;
[R1, xp]=radon(I, theta1);
[R2, xp]=radon(I, theta2);
[R3, xp]=radon(I, theta3);
figure;
imagesc(theta3, xp, R3);
colormap hot;
colorbar;
J1=iradon(R1, 10);
J2=iradon(R2, 5);
J3=iradon(R3, 2);
figure;
subplot(131);
imshow(J1);
subplot(132);
imshow(J2);
subplot(133);
imshow(J3);

