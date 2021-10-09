
clear all; close all;
I=imread('glass.png');		
J=imcomplement(I);			
figure;
subplot(121);
imshow(uint8(I));		
subplot(122);
imshow(uint8(J));	
