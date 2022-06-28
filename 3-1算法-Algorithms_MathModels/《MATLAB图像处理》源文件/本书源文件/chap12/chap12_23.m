

clear all; close all;
fun=@(x) (sum(x(:))==4);
lut=makelut(fun, 2);
I=imread('text.png');
J=applylut(I, lut);
figure;
subplot(121);  imshow(I);
subplot(122);  imshow(J);