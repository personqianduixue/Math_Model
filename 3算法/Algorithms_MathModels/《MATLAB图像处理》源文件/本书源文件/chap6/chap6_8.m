

clear all; close all;
m=256; n=256;
a=50;
b=180;
I=a+(b-a)*rand(m,n);
figure;
subplot(121);  imshow(uint8(I));
subplot(122);  imhist(uint8(I));

