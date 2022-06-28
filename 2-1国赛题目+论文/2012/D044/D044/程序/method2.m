clear
clc
close all
theta=0:pi/100:2*pi;
zb{1}=[300 400;500 400;500 600;300 600];
zb{2}=[550 450;80 80];
zb{3}=[360 240;500 240;540 330;400 330;];
zb{4}=[280 100;410 100;345 210;];
zb{5}=[80 60;230 60;230 210;80 210];
zb{6}=[60 300;235 300;150 435;];
zb{7}=[0 470;220 470;220 530;0 530];
zb{8}=[150 600;240 600;270 680;180 680];
zb{9}=[370 680;430 680;430 800;370 800];
zb{10}=[540 600;670 600;670 730;540 730];
zb{11}=[640 520;720 520;720 600;640 600];
zb{12}=[500 140;800 140;800 200;500 200];
zb{13}=[0 0 79];
zb{14}=[0 0 79];
zb{15}=[300 300 65];
zb{16}=[100 700 66];
zb{17}=[700 640 67];
%***********************计算区域内所有的直线段的方程*************************
lines=[];kxyh=[];
for i=1:length(zb)
    temp=zb{i};
    if size(zb{i},1)==2
        x=temp(2,1)*cos(theta)+temp(1,1);
        y=temp(2,2)*sin(theta)+temp(1,2);
        plot(x,y,'b-');hold on
    elseif size(temp,1)==3
        temp0=temp+[-10 -10;10 -10;0 10];
        for j=1:size(temp,1)
            if j==size(temp,1)   tt=1;  else   tt=j+1; end
            lines=[lines [temp(j,1);temp(j,2);temp(tt,1);temp(tt,2)]];
        end
        plot([temp(:,1);temp(1,1)],[temp(:,2);temp(1,2)],'b-');hold on
    elseif size(temp,1)==4
        if i==13
            temp0=temp+[10 10;-10 10;-10 -10;10 -10];
        else
            temp0=temp+[-10 -10;10 -10;10 10;-10 10];
        end
        for j=1:size(temp,1)
            if j==size(temp,1) tt=1; else tt=j+1;end
            lines=[lines [temp(j,1);temp(j,2);temp(tt,1);temp(tt,2)]];
        end
        plot([temp(:,1);temp(1,1)],[temp(:,2);temp(1,2)],'b-');hold on
    elseif size(temp,1)==1
        plot(temp(1),temp(2),'r.','MarkerSize',12);text(temp(1)+10,temp(2)+20,char(temp(3)));hold on
    end
    if i<=12&i~=2
        for j=1:size(temp,1)
            temp1=temp(j,:);
            x=10*cos(theta)+temp1(1);
            y=10*sin(theta)+temp1(2);
            plot(x,y,'b-');hold on
        end
    end
end
axis([0 800 0 800]);grid on
%***********************计算区域内所有的圆弧段的方程*************************
kkk=1;
for i=1:length(zb)-4
    temp5=zb{i};if i==2 pp=1;else pp=size(temp5);end
    for j=1:pp
        if ~ismember(temp5(j,1),[0,800]) & ~ismember(temp5(j,2),[0,800])
            if j==1   ppp=size(temp5,1);  else   ppp=j-1; end
            if j==size(temp5,1) tt=1; else tt=j+1;end
            kxyh(:,kkk)=[temp5(ppp,1);temp5(ppp,2);temp5(j,1);temp5(j,2);temp5(tt,1);temp5(tt,2)];
            yxzb(1:2,kkk)=temp5(j,:);
            if i==2 yxzb(3,kkk)=80;else yxzb(3,kkk)=10;end
            kkk=kkk+1;
        end
    end
end
% ******************下面计算四个点O,A,B,C到各个圆弧的可行路径****************
yxbh=0;
for i=1:4
    %**********************计算四个点到各园的切点坐标************************
    x=[];y=[];z=[];kk=1;
    temp=zb{13+i};A=temp(1:2);
    for j=1:12
        temp2=zb{j};
        if j==2
            r=70;temp2=temp2(1,:);
        else
            r=10;
        end
        for k=1:size(temp2,1)
            B=temp2(k,:);
            if ~ismember(B(1),[0,800]) & ~ismember(B(2),[0,800])
                [x(:,kk) y(:,kk)]=qiedian(A,B,r);
                z=[z kk];
                kk=kk+1;
            end
        end
    end
    qdzb=[reshape(x,1,2*length(x));reshape(y,1,2*length(y));reshape([z;z],1,2*length(z))];
    %*****%********************判断是否为可行路径***************************
    temp3=ones(length(qdzb),length(lines));
    for p=1:length(qdzb)
        %******************判断与直线段间距离小于10单位**************************
        for q=1:length(lines)
            if distancebetweenlines(A,qdzb(1:2,p),lines(1:2,q),lines(3:4,q),100)>=10-0.01
                temp3(p,q)=0;
            else
                temp3(p,q)=1;
            end
        end
    end
    ind{i}=find(sum(temp3,2)==0);temp4=ind{i};
    for p=1:length(temp4)
        plot([A(1) qdzb(1,temp4(p))],[A(2) qdzb(2,temp4(p))],'r-');hold on
    end
    dykxlj{i,1}=[repmat(A',1,length(ind{i}));[qdzb(1,ind{i});qdzb(2,ind{i})];repmat([length(yxzb)+i],1,length(ind{i}));qdzb(3,ind{i})];
end
%%%******************下面计算各个圆与圆之间的可行路径***********************
yykxlj=[];
for i=1:length(yxzb)
    for j=i+1:length(yxzb)
        temp6=yuanyuanqiexian(yxzb(1:2,i),yxzb(3,i),yxzb(1:2,j),yxzb(3,j));
        temp7=[];
        for k=1:size(temp6,2)
           %******************判断与直线段间距离小于10单位************************
            for L=1:length(lines)
                    temp7(k,L)=distancebetweenlines(temp6(1:2,k),temp6(3:4,k),lines(1:2,L),lines(3:4,L),100);
                if distancebetweenlines(temp6(1:2,k),temp6(3:4,k),lines(1:2,L),lines(3:4,L),100)>=10-.01
                    temp7(k,L)=0;
                else
                    temp7(k,L)=1;
                end
            end
        end
        ind2=find(sum(temp7,2)==0);
        if ~isempty(ind2)
            yykxlj=[yykxlj [temp6(:,ind2);repmat([i;j],1,length(ind2))]];
        end
    end
end
for i=1:length(yykxlj)
    plot(yykxlj([1 3],i),yykxlj([2 4],i),'k-');hold on
end
