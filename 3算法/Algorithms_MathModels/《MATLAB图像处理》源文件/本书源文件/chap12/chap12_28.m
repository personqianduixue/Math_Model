

clear all; close all; clc;
I=imread('circbw.tif');
J=imread('circles.png');
e1=bweuler(I, 8)
e2=bweuler(J, 8)


