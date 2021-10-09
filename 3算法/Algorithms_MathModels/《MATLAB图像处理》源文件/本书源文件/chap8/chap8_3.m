
clear all; close all;
I=fitsread('solarspectra.fts');
J=mat2gray(I);
BW=edge(J);
figure;
subplot(121);
imshow(J);
subplot(122);
imshow(BW);
theta=0:179;
[R, xp]=radon(BW, theta);
figure;
imagesc(theta, xp, R);
colormap(hot);
colorbar;
Rmax=max(max(R))
[row, column]=find(R>=Rmax)
x=xp(row)
angel=theta(column)
