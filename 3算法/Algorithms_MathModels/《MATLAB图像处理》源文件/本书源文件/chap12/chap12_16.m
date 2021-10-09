

clear all; close all; clc;
I=2*ones(5, 10);
I(2:4, 2:4)=3;
I(4:5, 6:7)=9;
I(2,8)=5
J=imregionalmax(I)
K=imhmax(I, 4)

