clear all;close all;clc
%初始化邻接压缩表
b=[1 2;1 3;1 4;2 4;
3 6;4 6;4 7];
c=b(:)
m=max(b(:));             %压缩表中最大值就是邻接矩阵的宽与高
A=compresstable2matrix(b) %从邻接压缩表构造图的矩阵表示
netplot(A,1)                %形象表示
title('原始网络拓扑图'); 
top=1;                  %堆栈顶
stack(top)=1;           %将第一个节点入栈

flag=1;                 %标记某个节点是否访问过了
re=[];                  %最终结果
while top~=0            %判断堆栈是否为空
    pre_len=length(stack);    %搜寻下一个节点前的堆栈长度
    i=stack(top);             %取堆栈顶节点
    for j=1:m
        if A(i,j)==1 && isempty(find(flag==j,1))    %如果节点相连并且没有访问过 
            top=top+1;                          %扩展堆栈
            stack(top)=j;                       %新节点入栈
            flag=[flag j];                      %对新节点进行标记
            re=[re;i j];                        %将边存入结果
            break;   
        end
    end    
    if length(stack)==pre_len   %如果堆栈长度没有增加，则节点开始出栈
        stack(top)=[];
        top=top-1;
    end    
end

A=compresstable2matrix(re);
figure;
netplot(A,1)
title('深度优先网络拓扑图'); 