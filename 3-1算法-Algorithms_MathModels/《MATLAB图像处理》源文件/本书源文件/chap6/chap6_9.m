

clear all; close all;
m=256; n=256;
a=0.04;
k=-1/a;
I=k*log(1-rand(m, n));
figure;
subplot(121);  imshow(uint8(I));
subplot(122);  imhist(uint8(I));

