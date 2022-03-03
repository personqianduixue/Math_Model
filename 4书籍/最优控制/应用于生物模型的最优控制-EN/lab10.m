close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
var1=0;
var2=0;
var3=0;
var4=0;

while(flag1==0)
    var1 = input('Enter a value for the first parameter a: ');
    if(var1>0)
        a=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: a must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the second parameter b: ');
    if(var1>0)
        b=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: b must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the third parameter c: ');
    if(var1>0)
        c=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: c must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter an initial glucose level (x_10): ');
    if(var1>0)
        x10=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: x_10 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the weight parameter A: ');
    if(var1>=0)
        A=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: A must be non-negative.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the desired glucose level (l): ');
    if(var1>0)
        level = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: l must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter the number of days you would like to run this model: ');
    if(0<var1);
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
y1=code10(a,b,c,x10,A,level,T);
disp('          ')

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
            disp('1. a')
            disp('2. b')
            disp('3. c')
            disp('4. x_10')
            disp('5. A')
            disp('6. l')
            disp('7. T')
            var3 = input('Type 1 - 7: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second a value: ');
                    if(var4 > 0)
                        a2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: a must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code10(a2,b,c,x10,A,level,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second b value: ');
                    if(var4 > 0)
                        b2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: b must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code10(a,b2,c,x10,A,level,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second c value: ');
                    if(var4 > 0)
                        c2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: c must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code10(a,b,c2,x10,A,level,T);
                flag3=1; 
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second x_10 value: ');
                   if(var4 > 0)
                       x102 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: x_10 must be positive.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code10(a,b,c,x102,A,level,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second A value: ');
                    if(var4 >= 0)
                        A2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: A must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code10(a,b,c,x10,A2,level,T);
                flag3=1;
            elseif(var3==6)
                disp('           ')
                while(flag4==0)
                    var4=input('Enter a second l value: ');
                    if(var4 > 0)
                        level2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: l must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code10(a,b,c,x10,A,level2,T);
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
                y2=code10(a,b,c,x10,A,level,T2);
                flag3=1;
            else
                disp('         ')
                disp('Pardon?')
                disp('           ')
            end
        end
            
    elseif(var2==2)
        subplot(3,1,1);plot(y1(1,:),y1(2,:))
        subplot(3,1,1);xlabel('Days')
        subplot(3,1,1);ylabel('Glucose Concentration')
        subplot(3,1,2);plot(y1(1,:),y1(3,:))
        subplot(3,1,2);xlabel('Days')
        subplot(3,1,2);ylabel('Hormonal Concentration')
        subplot(3,1,3);plot(y1(1,:),y1(4,:))
        subplot(3,1,3);xlabel('Days')
        subplot(3,1,3);ylabel('Insulin')
        flag2=1;
    else
        disp('           ')
        disp('Pardon?')
        disp('            ')
    end
end

if(var2==1)
    subplot(3,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,1,1);xlabel('Days')
    subplot(3,1,1);ylabel('Glucose Concentration')
    subplot(3,1,1);legend('First value','Second value',0)
    subplot(3,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,1,2);xlabel('Days')
    subplot(3,1,2);ylabel('Hormonal Concentration')
    subplot(3,1,2);legend('First value','Second value',0)
    subplot(3,1,3);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(3,1,3);xlabel('Days')
    subplot(3,1,3);ylabel('Insulin')
    subplot(3,1,3);legend('First value','Second value',0)
end