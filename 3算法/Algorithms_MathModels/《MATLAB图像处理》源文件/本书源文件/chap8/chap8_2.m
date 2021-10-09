
clear all; close all;
I=zeros(200, 200);
I(50:150, 50:150)=1;
theta=0:10:180;
[R, xp]=radon(I, theta);
figure;
subplot(121);
imshow(I);
subplot(122);
imagesc(theta, xp, R);
colormap(hot);
colorbar;