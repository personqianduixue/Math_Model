close

flag1=0;
flag2=0;
flag3=0;
flag4=0;

while(flag1==0)
    var1 = input('Enter a positive value for the balancing coefficient parameter B: ');
    if(var1>0)
        flag1 = 1;
        B = var1;
    else
        disp('         ')
        disp('ERROR: B must be positive.')
        disp('         ')
    end
end
flag1 = 0;
disp('        ')
while(flag1==0)
    var1 = input('Enter a value for the spread rate k: ');
    if(var1>0)
        flag1 = 1;
        k = var1;
    else
        disp('         ')
        disp('ERROR: k must be positive positive.')
        disp('           ')
    end
end
disp('           ')
flag1 = 0;
while(flag1==0)
    var1 = input('Enter a positive integer for the length of the control period T: ');
    if(var1>0 & floor(var1)==var1)
        flag1 = 1;
        T = var1;
    else
        disp('           ')
        disp('ERROR: T must be a positive integer.')
        disp('            ')
    end    
end
flag1 = 0;
disp('           ')
disp('One moment please...')
[y1,z1]=code14(B,k,T);

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
            disp('1. B')
            disp('2. k')
            disp('3. T')
            var3=input('Type 1, 2, or 3: ');
            if(var3==1)
                disp('        ')
                while(flag4==0)
                    var4=input('Enter a second B value: ');
                    if(var4 > 0)
                        B2 = var4;
                        flag4 = 1;
                    else
                        disp('      ')
                        disp('ERROR: B must be positive.')
                        disp('        ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                [y2,z2]=code14(B2,k,T);
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
                [y2,z2]=code14(B,k2,T);
                flag3=1; 
            elseif(var3==3)
                disp('        ')
                while(flag4==0)
                    var4 = input('Enter a second T value: ');
                    if(var4 > 0 & floor(var4)==var4)
                        T2 = var4;
                        flag4 = 1;
                    else
                        disp('        ')
                        disp('ERROR: T must be a positive integer.')
                        disp('          ')
                    end
                end
                disp('            ')
                disp('One moment please...')
                [y2,z2]=code14(B,k,T2);
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
            subplot(1,2,1); plot(y1(1,:),y1(2,:),'bx:',y1(1,:),y1(3,:),'bx:',y1(1,:),y1(4,:),...
                'bx:',y1(1,:),y1(5,:),'bx:',y1(1,:),y1(6,:),'ro:')
            subplot(1,2,1); xlabel('Years')
            subplot(1,2,1); ylabel('Radius')
            subplot(1,2,2); plot(z1(1,:),z1(2,:),'bx:',z1(1,:),z1(3,:),'bx:',z1(1,:),z1(4,:),...
                'bx:',z1(1,:),z1(5,:),'bx:',z1(1,:),z1(6,:),'ro:')
            subplot(1,2,2); xlabel('Years')
            subplot(1,2,2); ylabel('Proportion of radius controlled')
    else 
        disp('     ')
        disp('Pardon?')
        disp('          ')
    end
end

if(var2==1)
    subplot(1,2,1); plot(y1(1,:),y1(2,:),'bx:',y1(1,:),y1(3,:),'bx:',y1(1,:),y1(4,:),...
                'bx:',y1(1,:),y1(5,:),'bx:',y1(1,:),y1(6,:),'ro:',y2(1,:),y2(2,:),'gx:',...
                y2(1,:),y2(3,:),'gx:',y2(1,:),y2(4,:),'gx:',y2(1,:),y2(5,:),'gx:',y2(1,:),y2(6,:),'mo:')
    subplot(1,2,1); xlabel('Years')
    subplot(1,2,1); ylabel('Radius')
    subplot(1,2,2); plot(z1(1,:),z1(2,:),'bx:',z1(1,:),z1(3,:),'bx:',z1(1,:),z1(4,:),...
                'bx:',z1(1,:),z1(5,:),'bx:',z1(1,:),z1(6,:),'ro:',z2(1,:),z2(2,:),'gx:',...
                z2(1,:),z2(3,:),'gx:',z2(1,:),z2(4,:),'gx:',z2(1,:),z2(5,:),'gx:',z2(1,:),z2(6,:),'mo:')
    subplot(1,2,2); xlabel('Years')
    subplot(1,2,2); ylabel('Proportion of radius controlled')
end