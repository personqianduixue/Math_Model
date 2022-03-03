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
    var1 = input('Enter a value for maximum mass k: ');
    if(var1>0)
        k=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: k must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for natrual death rate m: ');
    if(var1>0)
        m=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: m must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for initial population (x_0): ');
    if(var1>0)
        x0=var1;
        flag1=1;
    else
        disp('        ')
        disp('ERROR: x0 must be positive.')
        disp('        ')
    end
end
flag1=0;
disp('          ')
while(flag1==0)
    var1 = input('Enter a value for the upper bound M: ');
    if(var1>=0)
        M=var1;
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
    var1 = input('Enter the number of weeks you would like to run this simulation (T): ');
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
y1=code6(A,k,m,x0,M,T);

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
            disp('1. A')
            disp('2. k')
            disp('3. m')
            disp('4. x_0')
            disp('5. M')
            disp('6. T')
            var3=input('Type 1 - 6: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second A value: ');
                    if(var4 >= 0)
                        A2 = var4;
                        flag4 = 1;
                    else
                        disp('            ')
                        disp('ERROR: A must be non-negative.')
                        disp('       ')
                    end
                end
                disp('       ')
                disp('One moment please...')
                y2=code6(A2,k,m,x0,M,T);
                flag3=1;
            elseif(var3==2)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second k value: ');
                    if(var4 > 0)
                        k2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: k must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code6(A,k2,m,x0,M,T);
                flag3=1;
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second m value: ');
                    if(var4 > 0)
                        m2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: m must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                y2=code6(A,k,m2,x0,M,T);
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
                y2=code6(A,k,m,x02,M,T);
                flag3=1;
            elseif(var3==5)
                disp('        ')
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
                y2=code6(A,k,m,x0,M2,T);
                flag3=1;
            elseif(var3==6)
                disp('        ')
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
                y2=code6(A,k,m,x0,M,T2);
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
            subplot(3,1,1);xlabel('Weeks')
            subplot(3,1,1);ylabel('Fish Concentration')
            subplot(3,1,2);plot(y1(1,:),y1(3,:))
            subplot(3,1,2);xlabel('Weeks')
            subplot(3,1,2);ylabel('Harvesting Rate')
            t = y1(1,:);
            w = (k*t)./(t+1);
            subplot(3,1,3);plot(t,w)
            subplot(3,1,3);xlabel('Weeks')
            subplot(3,1,3);ylabel('Average Weight')
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(3,1,1);plot(y1(1,:),y1(2,:),'b',y2(1,:),y2(2,:),'g')
    subplot(3,1,1);xlabel('Weeks')
    subplot(3,1,1);ylabel('Fish Concentration')
    subplot(3,1,1);legend('First value','Second value',0)
    subplot(3,1,2);plot(y1(1,:),y1(3,:),'b',y2(1,:),y2(3,:),'g')
    subplot(3,1,2);xlabel('Weeks')
    subplot(3,1,2);ylabel('Harvesting Rate')
    subplot(3,1,2);legend('First value','Second value',0)
    if(var3==2)
        t = y1(1,:);
        w1 = (k*t)./(t+1);
        w2 = (k2*t)./(t+1);
        subplot(3,1,3);plot(t,w1,'b',t,w2,'g')
        subplot(3,1,3);xlabel('Weeks')
        subplot(3,1,3);ylabel('Average Weight')
    elseif(var3==6)
        T3 = max(T,T2);
        t = linspace(0,T3,1001);
        w = (k*t)./(t+1);
        subplot(3,1,3);plot(t,w)
        subplot(3,1,3);xlabel('Weeks')
        subplot(3,1,3);ylabel('Average Weight')
    else
        t = y1(1,:);
        w = (k*t)./(t+1);
        subplot(3,1,3);plot(t,w)
        subplot(3,1,3);xlabel('Weeks')
        subplot(3,1,3);ylabel('Average Weight')
    end
end