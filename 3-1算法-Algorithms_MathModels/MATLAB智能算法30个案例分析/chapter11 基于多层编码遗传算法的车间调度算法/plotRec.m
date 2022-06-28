function PlotRec(mPoint1,mPoint2,mText)

%mPoint1=10;
%mPoint2=15;
%mText=1;

vPoint =zeros(4,2);
vPoint(1,:)=[mPoint1,mText-0.5];
vPoint(2,:)=[mPoint2,mText-0.5];
vPoint(3,:)=[mPoint1,mText];
vPoint(4,:)=[mPoint2,mText];

plot([vPoint(1,1),vPoint(2,1)],[vPoint(1,2),vPoint(2,2)])
hold on;
plot([vPoint(1,1),vPoint(3,1)],[vPoint(1,2),vPoint(3,2)])
plot([vPoint(2,1),vPoint(4,1)],[vPoint(2,2),vPoint(4,2)])
plot([vPoint(3,1),vPoint(4,1)],[vPoint(3,2),vPoint(4,2)])

end 