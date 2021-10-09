function [ newpath , position ] = swap( oldpath , number )
% 对 oldpath 进 行 互 换 操 作
% number 为 产 生 的 新 路 径 的 个 数
% position 为 对 应 newpath 互 换 的 位 置
m = length( oldpath ) ; % 城 市 的 个 数
newpath = zeros( number , m ) ;
position = sort( randi( m , number , 2 ) , 2 ); % 随 机 产 生 交 换 的 位 置
for i = 1 : number
    newpath( i , : ) = oldpath ;
    % 交 换 路 径 中 选 中 的 城 市
    newpath( i , position( i , 1 ) ) = oldpath( position( i , 2 ) ) ;
    newpath( i , position( i , 2 ) ) = oldpath( position( i , 1 ) ) ;
end