

clear all; close all;
I=zeros(200, 200);
I(50:150, 50:150)=1;
[R, xp]=radon(I, [0, 45]);
figure;
subplot(131);
imshow(I);
subplot(132);
plot(xp, R(:, 1));
subplot(133);
plot(xp, R(:, 2));

