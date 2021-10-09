clear all;close all;clc
%初始化邻接压缩表
b=[1 2;1 3;1 4;2 4;3 6;4 6;4 7];

m=max(b(:));                %压缩表中最大值就是邻接矩阵的宽与高
A=compresstable2matrix(b);  %从邻接压缩表构造图的矩阵表示
netplot(A,1)                %形象表示

head=1;             %队列头
tail=1;             %队列尾，开始队列为空，tail==head
queue(head)=1;      %向头中加入图第一个节点
head=head+1;        %队列扩展

flag=1;             %标记某个节点是否访问过了
re=[];              %最终结果
while tail~=head    %判断队列是否为空
    i=queue(tail);  %取队尾节点
    for j=1:m
        if A(i,j)==1 && isempty(find(flag==j,1))    %如果节点相连并且没有访问过
            queue(head)=j;                          %新节点入列
            head=head+1;                            %扩展队列
            flag=[flag j];                          %对新节点进行标记
            re=[re;i j];                            %将边存入结果
        end
    end
    tail=tail+1;            
end

A=compresstable2matrix(re);
figure;
netplot(A,1)