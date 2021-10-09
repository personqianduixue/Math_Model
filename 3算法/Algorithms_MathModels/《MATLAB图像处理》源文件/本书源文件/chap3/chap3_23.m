close all;                                    %关闭当前所有图形窗口
clear all;                                     %清空工作空间变量
clc;                                         %清屏
load mri
mov = immovie(D,map);
implay(mov)
