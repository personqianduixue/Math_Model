function [ out ] = get_degree(A,k)
%GET_DEGREE Summary of this function goes here
%   Detailed explanation goes here
%A为邻接矩阵
%得到网络A节点为k的度
row = A(k,:);
out=size(find(row==1),2);
end

