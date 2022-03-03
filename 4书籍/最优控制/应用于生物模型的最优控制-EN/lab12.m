close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a positive value for the degradation rate K: ');
    if(var1>0)
        K=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: K must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for the maximum growth rate G: ');
    if(var1>0)
        G=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: G must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a positive value for the death rate D: ');
    if(var1>0)
        D=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: D must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the initial bacterial concentration x_0: ');
    if(var1>0)
        x0=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: x_0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the initial contaminant concentration z_0: ');
    if(var1>0)
        z0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: z_0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the upperbound M: ');
    if(var1>=0)
        M = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: M must be non-negative.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter the number of days you would like to run this model (T): ');
    if(var1>0);
        T=var1;
        flag1=1;
    else
        disp('            ')
        disp('ERROR: T must be positive.')
        disp('            ')
    end
end
disp('           ')
disp('One moment please...')
y1=code12(K,G,D,x0,z0,M,T);

disp('               ')

while(flag2==0)
    disp('Would you like to vary any parameters?')
    disp('1. Yes')
    disp('2. No')
    var2=input('Type 1 or 2: ');
            
    if(var2==1)
        disp('         ')
        flag2=1;
        while(flag3==0)
            disp('Which parameter would you like to vary?')
            disp('1. K')
            disp('2. G')
            disp('3. D')
            disp('4. x_0')
            disp('5. z_0')
            disp('6. M')
            disp('7. T')
            var3=input('Type 1 - 7: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second K value: ');
                    if(var4 > 0)
                        K2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: K must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code12(K2,G,D,x0,z0,M,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second G value: ');
                    if(var4 > 0)
                        G2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: G must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code12(K,G2,D,x0,z0,M,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second D value: ');
                    if(var4 > 0)
                        D2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: D must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code12(K,G,D2,x0,z0,M,T);
                flag3=1;    
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second x_0 value: ');
                    if(var4 > 0)
                        x02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: x_0 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code12(K,G,D,x02,z0,M,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second z_0 value: ');
                    if(var4 > 0)
                        z02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: z_0 must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code12(K,G,D,x0,z02,M,T);
                flag3=1;
            elseif(var3==6)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second M value: ');
                    if(var4 >= 0)
                        M2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: M must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code12(K,G,D,x0,z0,M2,T);
                flag3=1;
            elseif(var3==7)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second T value: ');
                    if(var4 > 0)
                        T2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: T must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code12(K,G,D,x0,z0,M,T2);
                flag3=1;
            else
                disp('         ')
                disp('Pardon?')
                disp('           ')
            end
        end
            
    elseif(var2==2)
            disp('            ')
            flag2=1;        
            subplot(3,1,1);plot(y1(1,:),y1(2,:))
            subplot(3,1,1);xlabel('Days')
            subplot(3,1,1);ylabel('Bacterial Concentration')
            subplot(3,1,2);plot(y1(1,:),y1(3,:))
            subplot(3,1,2);xlabel('Days')
            subplot(3,1,2);ylabel('Contaminant Concentration')
            subplot(3,1,3);plot(y1(1,:),y1(4,:))
            subplot(3,1,3);xlabel('Days')
            subplot(3,1,3);ylabel('Nutrient Concentration')
            subplot(3,1,3);axis([0 T -0.1 M+0.1])
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(3,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,1,1);xlabel('Days')
    subplot(3,1,1);ylabel('Bacterial Concentration')
    subplot(3,1,1);legend('First value','Second value',0)
    subplot(3,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,1,2);xlabel('Days')
    subplot(3,1,2);ylabel('Contaminnat Concentratioin')
    subplot(3,1,2);legend('First value','Second value',0)
    subplot(3,1,3);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(3,1,3);xlabel('Days')
    subplot(3,1,3);ylabel('Nutrient Concentration')
    subplot(3,1,3);legend('First value','Second value',0)
    if(var3==6)
        subplot(3,1,3);axis([0 T -0.1 0.1+max(M,M2)])
    elseif(var3==7)
        subplot(3,1,3);axis([0 max(T,T2) -0.1 M+0.1])
    else
        subplot(3,1,3);axis([0 T -0.1 M+0.1])
    end
end