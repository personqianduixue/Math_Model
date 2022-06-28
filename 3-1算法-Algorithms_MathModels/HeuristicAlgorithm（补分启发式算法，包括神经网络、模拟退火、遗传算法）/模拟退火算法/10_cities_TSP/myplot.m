function [ ] = myplot( path , coord , pathfar )
% 做 出 路 径 的 图 形
% path 为 要 做 图 的 路 径 ，coord 为 各 个 城 市 的 坐 标
% pathfar 为 路 径 path 对 应 的 费 用
len = length( path ) ;
clf ;
hold on ;
title( [ '近似最短路径如下，费用为' , num2str( pathfar ) ] ) ;
plot( coord( 1 , : ) , coord( 2 , : ) , 'ok');
pause( 0.4 ) ;
for ii = 2 : len
    plot( coord( 1 , path( [ ii - 1 , ii ] ) ) , coord( 2 , path( [ ii - 1 , ii ] ) ) , '-b');
    x = sum( coord( 1 , path( [ ii - 1 , ii ] ) ) ) / 2 ;
    y = sum( coord( 2 , path( [ ii - 1 , ii ] ) ) ) / 2 ;
    text( x , y , [ '(' , num2str( ii - 1 ) , ')' ] ) ;
    pause( 0.4 ) ;
end
plot( coord( 1 , path( [ 1 , len ] ) ) , coord( 2 , path( [ 1 , len ] ) ) , '-b' ) ;
x = sum( coord( 1 , path( [ 1 , len ] ) ) ) / 2 ;
y = sum( coord( 2 , path( [ 1 , len ] ) ) ) / 2 ;
text( x , y , [ '(' , num2str( len ) , ')' ] ) ;
pause( 0.4 ) ;
hold off ;