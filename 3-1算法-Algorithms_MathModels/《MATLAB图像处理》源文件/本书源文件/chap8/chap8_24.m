

clear all; close all;
I=imread('rice.png');
J=im2double(I);
T=dctmtx(8);
K=blkproc(J, [8 8], 'P1*x*P2', T, T');
mask=[ 1  1  1  1  0  0  0  0
            1  1  1  0  0  0  0  0
            1  1  0  0  0  0  0  0
            1  0  0  0  0  0  0  0
            0  0  0  0  0  0  0  0
            0  0  0  0  0  0  0  0
            0  0  0  0  0  0  0  0
            0  0  0  0  0  0  0  0 ];
K2=blkproc(K, [8 8], 'P1.*x', mask);
L=blkproc(K2, [8 8], 'P1*x*P2', T', T);
figure;
subplot(121);
imshow(J);
subplot(122);
imshow(L);
