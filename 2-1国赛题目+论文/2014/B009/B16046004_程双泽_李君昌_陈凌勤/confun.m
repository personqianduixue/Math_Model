function [c,ceq]=confun(ts)
%ts=[theta,s];

global w h a W r x lamda;
l=w+h/sin(ts(1));
d=l-ts(2);
q=sqrt(r^2-x.^2);
len=sqrt(d^2-+w^2+r^2-x.^2-2*(d*cos(ts(1))+w)*q+2*d*w*cos(ts(1)))+q-d-w;

c=[a*W-2*(w+h*cot(ts(1)));
    -(q+(d*cos(ts(1))+w-q).*(l-q)./sqrt(d^2-+w^2+r^2-x.^2-2*(d*cos(ts(1))+w)*q+2*d*w*cos(ts(1))));
    len-ts(2)+lamda
    ];
ceq=[];
