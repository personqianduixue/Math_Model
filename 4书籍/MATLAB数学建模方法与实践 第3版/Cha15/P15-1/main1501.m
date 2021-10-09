% 2004 CUMCM 奥运商区优化模型求解
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%MYFSAPLP SOLVE THE PLP IN THE THIRD PROBLEM BY SA ALGORITHM.
%首先只考虑n为偶数的情况
%变量初始化
clc
clf
clear;
xmin = 0; xmax = 200; ymin = 0; ymax = 150;
r = 25; n =6;
fval_every=1; fval_best=fval_every; fval_pro=fval_every;
lamdao=1e30; fs_every=1;
t0=98; tf=3; a=0.98; t=t0; t_mid=50;
p=1;
dfo=0;
while(t>tf)
	if p==1
		%产生新解
		for i=1:n./2
            x(i.*2-1)=r+2*r*(i-1);
            x(i*2)=r+2*r*(i-1);
            y(2*i-1)=r;
            y(2*i)=3*r;
		end
        for i=1:(n-1)
            for j=(i+1):n
                fs_every=fs_every.*sqrt((x(i)-x(j)).^2+(y(i)-y(j)).^2);
            end
        end
        fs_every=fs_every.^(1./n);
        fval_every=fs_every;
        dfval=fval_pro-fval_every;
		if dfval<0
            if p~=1
                x(i)=x0;
                y(i)=y0;
                fval_pro=fval_every;
                fs_pro=fs_every;
                dfo_pro=dfo;
            else
                fval_pro=fval_every;
                fs_pro=fs_every;
                dfo_pro=dfo;
            end
		else
            rand_jud=rand;
            if rand_jud>exp(-dfval./t)
                x(i)=x0;
                y(i)=y0;
                fval_pro=fval_every;
                fs_pro=fs_every;
                dfo_pro=dfo;
            else
                fs_every=fs_pro;
                fval_every=fval_pro;
                dfo=dfo_pro;
            end
		end
        if fval_every>fval_best
            x_best=x;
            y_best=y;
            fval_best=fval_every;
            fs_best=fs_every;
            dfo_bestk=dfo;
        end
        p=p-1;
        
	else
%         keyboard
        for k=1:500.*n
            i=ceil(rand.*n);
            x0=(xmin+r)+rand*((xmax-r)-(xmin+r));
            y0=(ymin+r)+rand*((ymax-r)-(ymin+r));
            for j=1:n
                if j~=i
                    dis0=sqrt((x(j)-x(i)).^2+(y(j)-y(i)).^2);
                    dis1=sqrt((x(j)-x0).^2+(y(j)-y0).^2);
                    if dis0 < 2*r
                        dfo=dfo-1;  
                    else
                        dfo=dfo+1;
                    end
                    if dis1 < 2*r
                        dfo=dfo+1;
                    else
                        dfo=dfo-1;
                    end
                    fs_every=fs_every./dis0.^(1./n);
                    fs_every=fs_every.*dis1.^(1./n);
                end
            end
            dfo_tmp=dfo./2;
            fval_every=fs_every-dfo_tmp.*lamdao./t;      
            
			dfval=fval_pro-fval_every;
			if dfval<0
                if p~=1
                    x(i)=x0;
                    y(i)=y0;
                    fval_pro=fval_every;
                    fs_pro=fs_every;
                    dfo_pro=dfo;
                else
                    fval_pro=fval_every;
                    fs_pro=fs_every;
                    dfo_pro=dfo;
                end
			else
                rand_jud=rand;
                if rand_jud>exp(-dfval./t)
                    x(i)=x0;
                    y(i)=y0;
                    fval_pro=fval_every;
                    fs_pro=fs_every;
                    dfo_pro=dfo;
                else
                    fs_every=fs_pro;
                    fval_every=fval_pro;
                    dfo=dfo_pro;
                end
			end
            if fval_every>fval_best
                x_best=x;
                y_best=y;
                fval_best=fval_every;
                fs_best=fs_every;
                dfo_bestk=dfo;
            end
        end
    end
    t=t.*a;
end

%求解结束
x_center = x_best;
y_center = y_best;
disp('圆心坐标分别为：')
circle_center = [x_center; y_center]';
disp(circle_center)
%绘图
hold on
for i = 1 : length(x_center)
    x_plot_tmp = linspace(x_center(i)-r,x_center(i)+r);
    y_plot_tmp_up = ...
        sqrt(r.^2 - (x_plot_tmp - x_center(i)).^2) ...
            + y_center(i);
    y_plot_tmp_down = ...
        - sqrt(r.^2 - (x_plot_tmp - x_center(i)).^2) ...
            + y_center(i);
    plot(x_plot_tmp,y_plot_tmp_up);
    plot(x_plot_tmp,y_plot_tmp_down);
end
