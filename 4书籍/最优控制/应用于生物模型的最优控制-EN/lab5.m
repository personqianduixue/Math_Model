close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a value for the growth rate r: ');
    if(var1<=0)
        disp('        ')
        disp('ERROR: The growth rate r must be positive.');
        disp('        ')
    else
        r = var1;
        flag1 = 1;
    end
end
flag1 = 0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the weight parameter a: ');
    if(var1<0)
        disp('        ')
        disp('ERROR: The weight parameter a must be non-negative.');
        disp('        ')
    else
        a = var1;
        flag1 = 1;
    end
end
flag1 = 0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for delta (dose magnitude): ');
    if(var1<=0)
        disp('        ')
        disp('ERROR: The dose magnitude must be positive.');
        disp('        ')
    else
        d = var1;
        flag1 = 1;
    end
end
flag1 = 0;
disp('           ')
while(flag1==0)
    var1 = input('Enter a value for N_0 (initial tumor density): ');
    if((0<var1)&(1>var1))
        n0=var1;
        flag1=1;
    else
        disp('                ')
        disp('ERROR: N_0 must be between 0 and 1.');
        disp('                ')
    end
end
flag1 = 0;
disp('           ')
while(flag1==0)
    var1 = input('Enter the number of days you would like to run this simulation: ');
    if(var1 > 0)
        T=var1;
        flag1=1;
    else
        disp('                ')
        disp('ERROR: T must be positive.');
        disp('                ')
    end
end
disp('            ')
disp('One moment please...')
y1=code5(r,a,d,n0,T);
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
            disp('1. r')
            disp('2. a')
            disp('3. delta')
            disp('4. N_0')
            disp('5. T')
            var3=input('Type 1, 2, 3, 4, or 5: ');
            if(var3==1)
                while(flag4==0)
                    var4=input('Enter a second r value: ');
                    if(var4 > 0)
                        r2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: The growth rate r must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code5(r2,a,d,n0,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second a value: ');
                    if(var4 >= 0)
                        a2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: The weight parameter a must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code5(r,a2,d,n0,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second delta value: ');
                   if(var4 > 0)
                       d2 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: The dose magnitude must be positive.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code5(r,a,d2,n0,T);
                flag3=1;
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second N_0 value: ');
                    if((var4>0)&(var4<1))
                        n02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: N_0 must be between 0 and 1.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code5(r,a,d,n02,T);
                flag3=1;
            elseif(var3==5)
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
                y2=code5(r,a,d,n0,T2);
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
            subplot(2,1,1);plot(y1(1,:),y1(2,:))
            subplot(2,1,1);xlabel('Days')
            subplot(2,1,1);ylabel('Tumor Density')
            subplot(2,1,2);plot(y1(1,:),y1(3,:))
            subplot(2,1,2);xlabel('Days')
            subplot(2,1,2);ylabel('Pharmacokinetics')
    end
end
                
if(var2==1)
    subplot(2,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(2,1,1);xlabel('Days')
    subplot(2,1,1);ylabel('Tumor Density')
    subplot(2,1,1);legend('First value','Second value',0)
    subplot(2,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(2,1,2);xlabel('Days')
    subplot(2,1,2);ylabel('Pharmacokinetics')
    subplot(2,1,2);legend('First value','Second value',0)
end