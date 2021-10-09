
clear all; close all;
I=imread('pout.tif');
s1=std2(I)
J=histeq(I);
s2=std2(J)

