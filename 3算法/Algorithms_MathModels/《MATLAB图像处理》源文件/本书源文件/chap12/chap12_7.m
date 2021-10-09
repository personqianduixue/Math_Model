

clear all; close all;
se=strel('rectangle', [40, 30]);
bw1=imread('circbw.tif');
bw2=imerode(bw1, se);
bw3=imdilate(bw2, se);
figure;
subplot(131);  imshow(bw1);
subplot(132);  imshow(bw2);
subplot(133);  imshow(bw3);



