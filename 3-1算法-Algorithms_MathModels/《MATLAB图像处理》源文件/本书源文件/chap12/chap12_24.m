

clear all; close all; clc;
BW=zeros(4, 8);
BW(2:3, 2:3)=1;
BW(2, 5)=1;
BW(3, 7)=1
[L, num]=bwlabel(BW, 8)

