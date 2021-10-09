%% 元胞自动机（CA）MATLAB实现程序
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc, clf,clear 

%% 界面设计（环境的定义）
plotbutton=uicontrol('style','pushbutton',...
   'string','Run', ...
   'fontsize',12, ...
   'position',[100,400,50,20], ...
   'callback', 'run=1;');

% 定义 stop button
erasebutton=uicontrol('style','pushbutton',...
   'string','Stop', ...
   'fontsize',12, ...
   'position',[200,400,50,20], ...
   'callback','freeze=1;');

% 定义 Quit button
quitbutton=uicontrol('style','pushbutton',...
   'string','Quit', ...
   'fontsize',12, ...
   'position',[300,400,50,20], ...
   'callback','stop=1;close;');

number = uicontrol('style','text', ...
    'string','1', ...
   'fontsize',12, ...
   'position',[20,400,50,20]);

%%  元胞自动机的设置
n=128;
z = zeros(n,n);
cells = z;
sum = z;
cells(n/2,.25*n:.75*n) = 1;
cells(.25*n:.75*n,n/2) = 1;
cells = (rand(n,n))<.5 ;
imh = image(cat(3,cells,z,z));
axis equal
axis tight

% 元胞索引更新的定义
x = 2:n-1;
y = 2:n-1;

% 元胞更新的规则定义
stop= 0; % wait for a quit button push
run = 0; % wait for a draw 
freeze = 0; % wait for a freeze
while (stop==0) 
    if (run==1)
        %nearest neighbor sum
        sum(x,y) = cells(x,y-1) + cells(x,y+1) + ...
            cells(x-1, y) + cells(x+1,y) + ...
            cells(x-1,y-1) + cells(x-1,y+1) + ...
            cells(3:n,y-1) + cells(x+1,y+1);
        % The CA rule
        cells = (sum==3) | (sum==2 & cells);       
        % draw the new image
        set(imh, 'cdata', cat(3,cells,z,z) )
        % update the step number diaplay
        stepnumber = 1 + str2num(get(number,'string'));
        set(number,'string',num2str(stepnumber))
    end
    if (freeze==1)
        run = 0;
        freeze = 0;
    end
    drawnow  %need this in the loop for controls to work
end
