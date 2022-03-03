close

flag1=0;
flag2=0;
flag3=0;
flag4=0;
    
while(flag1==0)    
    var1 = input('Enter a value for the birth rate b: ');
    if(var1 > 0)
        b = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: b must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the natural death rate d: ');
    if(var1 > 0)
        d = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: d must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('            ')
while(flag1==0)    
    var1 = input('Enter a value for incidence rate c: ');
    if(var1 > 0)
        c = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: c must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('           ')
while(flag1==0)    
    var1 = input('Enter a value for the exposed to infectious rate e: ');
    if(var1 > 0)
        e = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: e must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('              ')
while(flag1==0)    
    var1 = input('Enter a value for recovery rate g: ');
    if(var1 >= 0)
        g = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: g must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for disease-caused death rate a: ');
    if(var1 > 0)
        a = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: a must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial susceptible population (S_0): ');
    if(var1 >= 0)
        S0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: S_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial exposed population (E_0): ');
    if(var1 >= 0)
        E0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: E_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial infectious population (I_0): ');
    if(var1 >= 0)
        I0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: I_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)    
    var1 = input('Enter a value for the initial recovered population (R_0): ');
    if(var1 >= 0)
        R0 = var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: R_0 must be non-negative.')
        disp('         ')
    end
end
flag1=0;
disp('         ')
while(flag1==0)
    var1 = input('Enter a value for the weight parameter A: ');
    if(var1>=0)
        A = var1;
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
    var1 = input('How many years would you like to run this system: ');
    if(var1>0)
        T=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: T must be positive.')
        disp('         ')
    end
end
flag1=0;
disp('              ')
disp('One moment please...')
y1=code7(b,d,c,e,g,a,S0,E0,I0,R0,A,T);
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
            disp('1. b')
            disp('2. d')
            disp('3. c')
            disp('4. e')
            disp('5. g')
            disp('6. a')
            disp('7. S0')
            disp('8. E0')
            disp('9. I0')
            disp('10. R0')
            disp('11. A')
            disp('12. T')
            var3 = input('Type 1 - 12: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second b value: ');
                    if(var4 > 0)
                        b2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: b must be positive.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code7(b2,d,c,e,g,a,S0,E0,I0,R0,A,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second d value: ');
                    if(var4 > 0)
                        d2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: d must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d2,c,e,g,a,S0,E0,I0,R0,A,T);
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
                y2=code7(b,d,c2,e,g,a,S0,E0,I0,R0,A,T);
                flag3=1; 
            elseif(var3==4)
                disp('        ')
                while(flag4==0)
                   var4=input('Enter a second e value: ');
                   if(var4 > 0)
                       e2 = var4;
                       flag4 = 1;
                   else
                       disp('      ')
                       disp('ERROR: e must be positive.')
                       disp('        ')
                   end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e2,g,a,S0,E0,I0,R0,A,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second g value: ');
                    if(var4 >= 0)
                        g2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: g must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g2,a,S0,E0,I0,R0,A,T);
                flag3=1;
            elseif(var3==6)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second a value: ');
                    if(var4 > 0)
                        a2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: a must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g,a2,S0,E0,I0,R0,A,T);
                flag3=1;
            elseif(var3==7)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second S_0 value: ');
                    if(var4 >= 0)
                        S02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: S_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g,a,S02,E0,I0,R0,A,T);
                flag3=1;
            elseif(var3==8)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second E_0 value: ');
                    if(var4 >= 0)
                        E02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: E_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g,a,S0,E02,I0,R0,A,T);
                flag3=1;
            elseif(var3==9)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second I_0 value: ');
                    if(var4 >= 0)
                        I02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: I_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g,a,S0,E0,I02,R0,A,T);
                flag3=1;
            elseif(var3==10)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second R_0 value: ');
                    if(var4 >= 0)
                        R02 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: R_0 must be non-negative.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code7(b,d,c,e,g,a,S0,E0,I0,R02,A,T);
                flag3=1;
            elseif(var3==11)
                disp('           ')
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
                y2=code7(b,d,c,e,g,a,S0,E0,I0,R0,A2,T);
                flag3=1;
            elseif(var3==12)
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
                y2=code7(b,d,c,e,g,a,S0,E0,I0,R0,A,T2);
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
            subplot(3,2,1);plot(y1(1,:),y1(2,:))
            subplot(3,2,1);xlabel('Time')
            subplot(3,2,1);ylabel('Susceptible')
            subplot(3,2,2);plot(y1(1,:),y1(3,:))
            subplot(3,2,2);xlabel('Time')
            subplot(3,2,2);ylabel('Exposed')
            subplot(3,2,3);plot(y1(1,:),y1(4,:))
            subplot(3,2,3);xlabel('Time')
            subplot(3,2,3);ylabel('Infectious')
            subplot(3,2,4);plot(y1(1,:),y1(5,:))
            subplot(3,2,4);xlabel('Time')
            subplot(3,2,4);ylabel('Recovered')
            subplot(3,2,5);plot(y1(1,:),y1(6,:))
            subplot(3,2,5);xlabel('Time')
            subplot(3,2,5);ylabel('Total Population')
            subplot(3,2,6);plot(y1(1,:),y1(7,:))
            subplot(3,2,6);xlabel('Time')
            subplot(3,2,6);ylabel('Vaccination Rate')
            subplot(3,2,6);axis([0 T -0.1 1])
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(3,2,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,2,1);xlabel('Time')
    subplot(3,2,1);ylabel('Susceptible')
    subplot(3,2,1);legend('First value','Second value',0)
    subplot(3,2,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,2,2);xlabel('Time')
    subplot(3,2,2);ylabel('Exposed')
    subplot(3,2,2);legend('First value','Second value',0)
    subplot(3,2,3);plot(y1(1,:),y1(4,:),'b',y2(1,:),y2(4,:),'g')
    subplot(3,2,3);xlabel('Time')
    subplot(3,2,3);ylabel('Infectious')
    subplot(3,2,3);legend('First value','Second value',0)
    subplot(3,2,4);plot(y1(1,:),y1(5,:),'b',y2(1,:),y2(5,:),'g')
    subplot(3,2,4);xlabel('Time')
    subplot(3,2,4);ylabel('Recovered')
    subplot(3,2,4);legend('First value','Second value',0)
    subplot(3,2,5);plot(y1(1,:),y1(6,:),'b',y2(1,:),y2(6,:),'g')
    subplot(3,2,5);xlabel('Time')
    subplot(3,2,5);ylabel('Total Population')
    subplot(3,2,5);legend('First value','Second value',0)
    subplot(3,2,6);plot(y1(1,:),y1(7,:),'b',y2(1,:),y2(7,:),'g')
    subplot(3,2,6);xlabel('Time')
    subplot(3,2,6);ylabel('Vaccination Rate')
    subplot(3,2,6);legend('First value','Second value',0)
    if(var3==10)
        subplot(3,2,6);axis([0 max(T,T2) -0.1 1])
    else
        subplot(3,2,6);axis([0 T -0.1 1])
    end
end