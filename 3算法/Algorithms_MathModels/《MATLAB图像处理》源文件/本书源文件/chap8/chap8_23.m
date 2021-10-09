
clear all; close all;
I=imread('cameraman.tif');
fun1=@dct2;
J1=blkproc(I, [8 8], fun1);
fun2=@(x) std2(x)*ones(size(x));
J2=blkproc(I, [8 8], fun2);
figure;
subplot(121);
imagesc(J1);
subplot(122);
imagesc(J2);
colormap gray;


