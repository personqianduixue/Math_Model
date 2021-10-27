% 定义变量，视其为全局变量，进行搜索运算
%数据说明：qamu qasigma stamu stasigma uomu uosigma ldownmu ldowmsigma lupmu lpsigma va2mu va2sigma x1mu x1sigma x2mu x2sigma
%    表示空气湿度qa  气温sta  总辐射度u0  降水量ldown  月蒸发量lup   风速va2  综合1x1 综合2x2 的均值和方差
%    global k  k1 kst l0  表示参数 k  k1 kst 以及地面温度l0.
%    global st0 表示地面温度st的均值,其方差转化为其它值表示

global qamu qasigma stamu stasigma uomu uosigma ldownmu ldowmsigma lupmu lpsigma va2mu va2sigma x1mu x1sigma x2mu x2sigma;
global k  k1 kst l0;
global st0;

%数据读入,数据为均值，基本结构为24*29*31
%% 29年中 某月份31天 每天个个时刻（h）的数据 

%%%%%%%%%%%%%%%%%%%%
%将均值数据值读入

%湿度qa
qa=[
    ];

%气温sta  
sta=[
    ];

%总辐射度u0  
u0=[
    ];

%降水量ldown  
ldown=[
    ];

%月蒸发量lup   
lup=[
    ];

%风速va2
va2=[
    ];
%各年份某月发生沙尘暴的频数值
    kk=[
        ];
%最小二乘法控制因子
sum=zeros(nian,1);
control=100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%空间搜索
for k=0:1:100
        for kst= 0:100           %对待定参数进行搜索 
                for k1=0:100
                    for l0=0:100
 %对分布方差 进行搜索
    for qasigma=1:20
        for stasigma=1:5
            for uosigma=40:50 
                for ldowmsigma=1:10
                    for lpsigma =10:20
                        for va2sigma =10:20
                            
 for nian=1:1:28
     for yue=nian:nian+31
            sum(nian,1)=0;      
          for h=1:24
                qamu=qa(yue,h); stamu=sta(yue,h); uomu=uo(yue,h); ldownmu=ldown(yue,h); lupmu=lup(yue,h); va2mu=va2(2,1); 
            
             stg0=kst*u0mu+st0;
             x1mu=4*kst*u0mu+4*st0-4*stamu;
             x1sigma=4*a*u0sigma.^2+4*stasigma.^2;
             x2mu=stamu-stg0-0.608*k*kst*k1*l0*u0mu-0.608*k*k1*stmu*ldownmu+0.608*k*stmu*k1*lupmu-0.608*k*stmu*l0*k1;
             x2sima=stasigma.^2+(kst*u0sigma).^2+0.608*k*kst*k1*l0*u0sigma.^2+0.608*k*k1*stmu*ldownsigma.^2+0.608*k*stmu*k1*lupsigma.^2+0.608*k*stmu*k1*lupsigma.^2;
                 
             %结果控制
                    if(ttdiv(1000)>0.4) 
                    sum(nian,1)=sum(nian,1)+1;  %对能见度进行控制，并统计其中可能产生沙尘暴的次数，进行控制。
                    end
          end
     end
 end
%%最小二乘法判断
    totil=0;
    for nian=1:29
         totil=totil+(sum(nian,1)-kk(nian,1)).^0.5;
    end
    totil=totil.^0.5;
    if totil=control
        control=totil;
        %%%保存最优值
            ekst=kst; 
            ek1=k1;        
            el0=l0;
            ek=k;
            eqasigma=qasigma;
            estasigma=stasigma;  
            euosigma=uosigma; 
            edowmsigma=dowmsigma;
            elpsigma=lpsigma;
            eva2sigma=va2sigma; 
            ex1sigma=x1sigma; 
            ex2sigma=x2sigma;
    end

                        end
                    end
                end
            end
        end
    end
                    end
                end
        end
end

                                
        
                