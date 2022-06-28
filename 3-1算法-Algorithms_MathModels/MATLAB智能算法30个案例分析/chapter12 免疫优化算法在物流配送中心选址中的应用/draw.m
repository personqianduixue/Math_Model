% 画出配送中心选址图
% 画出配送中心
cargox=bestchrom([1,3,5,7]);
cargoy=bestchrom([2,4,6,8]);

plot(cargox,cargoy,'rs','LineWidth',2,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','b',...
    'MarkerSize',10)
hold on

% 画出需求点
plot(suplocationx,suplocationy,'o','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',10)
hold on

% 连接图
carlocationx=bestchrom([1,3,5,7]);
carlocationy=bestchrom([2,4,6,8]);
for i=9:128
    
    superindex=fix((i-8)/6)+1;  % 需求点
    if superindex==21
        superindex=20;
    end
    k=mod((i-8),6);
    cargoindex=bestchrom(i);   % 配送中心
    
    x=[suplocationx(superindex),carlocationx(cargoindex)];
    y=[suplocationy(superindex),carlocationy(cargoindex)];
    switch k
        case 0;plot(x,y,'c');hold on
        case 1;plot(x,y,'r');hold on
        case 2;plot(x,y,'y');hold on
        case 3;plot(x,y,'b');hold on
        case 4;plot(x,y,'g');hold on
        case 5;plot(x,y,'m');hold on
    end  
end