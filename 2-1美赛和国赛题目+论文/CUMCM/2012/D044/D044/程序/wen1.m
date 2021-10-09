clear
clc
close all
theta=0:pi/100:2*pi;
zb{1}=[300 400;500 400;500 600;300 600];
zb{2}=[550 450;70 70];
zb{3}=[360 240;400 330;540 330;500 240];
zb{4}=[280 100;345 210;410 100];
zb{5}=[80 60;80 150+60;150+80 150+60;150+80 60;];
zb{6}=[60 300; 150 435;235 300];
zb{7}=[0 470;220 470;220 530;0 530];
zb{8}=[150 600;240 600;270 680;180 680];
zb{9}=[370 680;430 680;430 800;370 800];
zb{10}=[540 600;670 600;670 730;540 730];
zb{11}=[640 520;720 520;720 600;640 600];
zb{12}=[500 140;800 140;800 200;500 200];
zb{13}=[0 0;0 800;800 800;800 0;];
zb{14}=[0 0 79];
zb{15}=[300 300 65];
zb{16}=[100 700 66];
zb{17}=[700 640 67];
for i=1:length(zb)
    temp=zb{i};
    if size(zb{i},1)==2
        x=temp(2,1)*cos(theta)+temp(1,1);
        y=temp(2,2)*sin(theta)+temp(1,2);
        plot(x,y,'r-');hold on
    elseif size(zb{i},1)==3
        for j=1:length(temp)
            plot([temp(:,1);temp(1,1)],[temp(:,2);temp(1,2)],'b-');hold on
        end
    elseif size(zb{i},1)==4
        for j=1:length(temp)
            plot([temp(:,1);temp(1,1)],[temp(:,2);temp(1,2)],'b-');hold on
        end
    elseif size(zb{i},1)==1
        plot(temp(1),temp(2),'r.','MarkerSize',12);text(temp(1)+10,temp(2)+20,char(temp(3)));hold on
    end
    if i<=12&i~=2
        for j=1:size(temp,1)
            temp1=temp(j,:);
            x=10*cos(theta)+temp1(1);
            y=10*sin(theta)+temp1(2);
            plot(x,y,'r-');hold on
        end
    end
end
axis([0 800 0 800]);grid on
hold off
%下面计算切点坐标
for i=1:4
    x=[];y=[];kk=1;
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
                kk=kk+1;
            end
        end
    end
    qdzb(:,:,i)=[reshape(x,1,2*length(x));reshape(y,1,2*length(y))];
end

