

clear all; close all;
[X, map]=imread('trees.tif');
J=ind2gray(X, map);
K=im2bw(X, map, 0.4);
figure;
subplot(121);  imshow(J);
subplot(122);  imshow(K);

