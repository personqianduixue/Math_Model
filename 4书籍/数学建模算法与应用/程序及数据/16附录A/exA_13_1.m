syms x
dy=diff(log((x+2)/(1-x)),3);
dy=simple(dy)  %对符号函数进行化简
pretty(dy)     %Latex格式显示
