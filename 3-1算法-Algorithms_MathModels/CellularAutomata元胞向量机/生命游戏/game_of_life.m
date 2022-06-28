%% 生命游戏GUI
clc
clear all
%构造三个按钮
plotbutton=uicontrol('style','pushbutton',...
    'string','Run', ...
    'fontsize',12, ...
    'position',[100,400,50,20], ...
    'callback', 'run=1;');
erasebutton=uicontrol('style','pushbutton',...
    'string','Stop', ...
    'fontsize',12, ...
    'position',[200,400,50,20], ...
    'callback','freeze=1;');
quitbutton=uicontrol('style','pushbutton',...
    'string','Quit', ...
    'fontsize',12, ...
    'position',[300,400,50,20], ...
    'callback','stop=1;close;');
number = uicontrol('style','text', ...
    'string','1', ...
    'fontsize',12, ...
    'position',[20,400,50,20]);
%元胞个数
n=128;
z = zeros(n,n);
cells = z;
sum = z;
%初始化一部分元胞有生命
cells(n/2,.25*n:.75*n) = 1;
cells(.25*n:.75*n,n/2) = 1;
cells = (rand(n,n))<.5 ;
%创建图片
imh = image(cat(3,cells,z,z));
set(imh, 'erasemode', 'none')
axis equal
axis tight
x = 2:n-1;
y = 2:n-1;
stop= 0; 
run = 0; 
freeze = 0; 
while (stop==0)
    if (run==1)
        %周围活着的生命总数
        sum(x,y) = cells(x,y-1) + cells(x,y+1) + ...
            cells(x-1, y) + cells(x+1,y) + ...
            cells(x-1,y-1) + cells(x-1,y+1) + ...
            cells(3:n,y-1) + cells(x+1,y+1);
        %元胞规则
        cells = (sum==3) | (sum==2 & cells);
        %更新图片
        set(imh, 'cdata', cat(3,cells,z,z) )
        %更新迭代了几步
        stepnumber = 1 + str2num(get(number,'string'));
        set(number,'string',num2str(stepnumber))
    end
    
    if (freeze==1)
        run = 0;
        freeze = 0;
    end
    pause(0.02)
end