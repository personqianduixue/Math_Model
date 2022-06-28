

clear all; close all; clc;
I=10*ones(6, 10);
I(3:4, 3:4)=13;
I(4:5, 7:8)=18;
I(2,8)=15
bw=imregionalmax(I)


