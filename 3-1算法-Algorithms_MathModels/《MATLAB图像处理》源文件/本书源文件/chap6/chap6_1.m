

clear all; close all;
I=uint8(100*ones(256, 256));
J=imnoise(I, 'gaussian', 0, 0.01);
K=imnoise(I, 'gaussian', 0, 0.03);
figure;
subplot(121);  imshow(J);
subplot(122);  imhist(J);
figure;
subplot(121);  imshow(K);
subplot(122);  imhist(K);


