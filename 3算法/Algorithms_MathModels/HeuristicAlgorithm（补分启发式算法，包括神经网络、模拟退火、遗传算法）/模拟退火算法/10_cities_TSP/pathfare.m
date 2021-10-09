function [ objval ] = pathfare( fare , path )
% 计 算 路 径 path 的 代 价 objval
% path 为 1 到 n 的 排 列 ，代 表 城 市 的 访 问 顺 序 ；
% fare 为 代 价 矩 阵 ， 且 为 方 阵 。
[ m , n ] = size( path ) ;
objval = zeros( 1 , m ) ;
for i = 1 : m
    for j = 2 : n
        objval( i ) = objval( i ) + fare( path( i , j - 1 ) , path( i , j ) ) ;
    end
    objval( i ) = objval( i ) + fare( path( i , n ) , path( i , 1 ) ) ;
end