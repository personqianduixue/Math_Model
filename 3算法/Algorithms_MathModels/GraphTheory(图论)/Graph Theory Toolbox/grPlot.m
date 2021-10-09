function h=grPlot(V,E,kind,vkind,ekind)
% Function h=grPlot(V,E,kind,vkind,ekind) 
% draw the plot of the graph (digraph).
% Input parameters: 
%   V(n,2) or (n,3) - the coordinates of vertexes
%     (1st column - x, 2nd - y) and, maybe, 3rd - the weights;
%     n - number of vertexes.
%     If V(n,2), we write labels: numbers of vertexes,
%     if V(n,3), we write labels: the weights of vertexes.
%     If V=[], use regular n-angle.
%   E(m,2) or (m,3) - the edges of graph (arrows of digraph)
%     and their weight; 1st and 2nd elements of each row 
%     is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If E(m,2), we write labels: numbers of edges (arrows);
%     if E(m,3), we write labels: weights of edges (arrows).
%     For disconnected graph use E=[] or h=PlotGraph(V).
%   kind - the kind of graph.
%   kind = 'g' (to draw the graph) or 'd' (to draw digraph);
%   (optional, 'g' default).
%   vkind - kind of labels for vertexes (optional).
%   ekind - kind of labels for edges or arrows (optional).
%   For vkind and ekind use the format of function FPRINTF,
%   for example, '%8.3f', '%14.10f' etc. Default value is '%d'.
%   Use '' (empty string) for don't draw labels.
% Output parameter:
%   h - handle of figure (optional).
% See also GPLOT.
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru
% Acknowledgements to Mr.Howard (howardz@cc.gatech.edu)
% for testing of this algorithm.

% ============= Input data validation ==================
if nargin<1,
  error('There are no input data!')
end
if (nargin==1) & isempty(V),
  error('V is empty and E is not determined!')
end
if (nargin==2) & isempty(V) & isempty(E),
  error('V and E are empty!')
end
if ~isempty(V),
  if ~isnumeric(V),
    error('The array V must be numeric!') 
  end
  sv=size(V); % size of array V
  if length(sv)~=2,
    error('The array V must be 2D!') 
  end
  if (sv(2)<2),
    error('The array V must have 2 or 3 columns!'), 
  end
  if nargin==1, % disconnected graph
    E=[];
  end
end
if ~isempty(E), % for connected graph
  [m,n,newE]=grValidation(E);
  we=min(3,size(E,2)); % 3 for weighed edges
  E=newE;
  if isempty(V), % regular n-angle
    V=[cos(2*pi*[1:n]'/n) sin(2*pi*[1:n]'/n)];
    sv=size(V); % size of array V
  end
  if n>sv(1),
    error('Several vertexes is not determined!');
  end
else
  m=0;
end

% ============= Other arguments ==================
n=sv(1); % real number of vertexes
wv=min(3,sv(2)); % 3 for weighted vertexes
if nargin<3, % only 2 input parameters
  kind1='g';
else
  if isempty(kind),
    kind='g';
    kind1='g';
  end
  if ~ischar(kind),
    error('The argument kind must be a string!')
  else
    kind1=lower(kind(1));
  end
end
if nargin<4,
  vkind1='%d';
else
  if ~ischar(vkind),
    error('The argument vkind must be a string!')
  else
    vkind1=lower(vkind);
  end
end
if nargin<5,
  ekind1='%d';
else
  if ~ischar(ekind),
    error('The argument ekind must be a string!')
  else
    ekind1=lower(ekind);
  end
end
md=inf; % the minimal distance between vertexes
for k1=1:n-1,
  for k2=k1+1:n,
    md=min(md,sum((V(k1,:)-V(k2,:)).^2)^0.5);
  end
end
if md<eps, % identical vertexes
  error('The array V have identical rows!')
else
  V(:,1:2)=V(:,1:2)/md; % normalization
end
r=0.1; % for multiple edges
tr=linspace(pi/4,3*pi/4);
xr=0.5-cos(tr)/2^0.5;
yr=(sin(tr)-2^0.5/2)/(1-2^0.5/2);
t=linspace(-pi/2,3*pi/2); % for loops
xc=0.1*cos(t);
yc=0.1*sin(t);

% we sort the edges
if ~isempty(E),
  E=[zeros(m,1),[1:m]',E]; % 1st column for change, 2nd column is edge number
  need2=find(E(:,4)<E(:,3)); % for replace v1<->v2
  tmp=E(need2,3);
  E(need2,3)=E(need2,4);
  E(need2,4)=tmp;
  E(need2,1)=1; % 1, if v1<->v2
  [e1,ie1]=sort(E(:,3)); % sort by 1st vertex
  E1=E(ie1,:);
  for k2=E1(1,3):E1(end,3),
    num2=find(E1(:,3)==k2);
    if ~isempty(num2), % sort by 2nd vertex
      E3=E1(num2,:);
      [e3,ie3]=sort(E3(:,4));
      E4=E3(ie3,:);
      E1(num2,:)=E4;
    end
  end
  ip=find(E1(:,3)==E1(:,4)); % we find loops
  Ep=E1(ip,:); % loops
  E2=E1(setdiff([1:m],ip),:); % edges without loops
end

% we paint the graph
hh=figure;
hold on
plot(V(:,1),V(:,2),'k.','MarkerSize',20)
axis equal
h1=get(gca); % handle of current figure
if ~isempty(vkind1), % labels of vertexes
  for k=1:n,
    if wv==3,
      s=sprintf(vkind1,V(k,3));
    else
      s=sprintf(vkind1,k);
    end
    hhh=text(V(k,1)+0.05,V(k,2)-0.07,s);
%    set(hhh,'FontName','Times New Roman Cyr','FontSize',18)
  end
end

% edges (arrows)
if ~isempty(E),
  k=0;
  m2=size(E2,1); % number of edges without loops
  while k<m2,
    k=k+1; % current edge
    MyE=V(E2(k,3:4),1:2); % numbers of vertexes 1, 2
    k1=1; % we find the multiple edges
    if k<m2,
      while all(E2(k,3:4)==E2(k+k1,3:4)),
        k1=k1+1;
        if k+k1>m2,
          break;
        end
      end
    end
    ry=r*[1:k1];
    ry=ry-mean(ry); % radius
    l=norm(MyE(1,:)-MyE(2,:)); % lenght of line
    dx=MyE(2,1)-MyE(1,1);
    dy=MyE(2,2)-MyE(1,2);
    alpha=atan2(dy,dx); % angle of rotation
    cosa=cos(alpha);
    sina=sin(alpha);
    MyX=xr*l;
    for k2=1:k1, % we draw the edges (arrows)
      MyY=yr*ry(k2);
      MyXg=MyX*cosa-MyY*sina+MyE(1,1);
      MyYg=MyX*sina+MyY*cosa+MyE(1,2);
      plot(MyXg,MyYg,'k-');
      if kind1=='d', % digraph with arrows
        if E2(k+k2-1,1)==1,
          [xa,ya]=CreateArrow(MyXg(1:2),MyYg(1:2));
          fill(xa,ya,'k');
        else
          [xa,ya]=CreateArrow(MyXg(end:-1:end-1),MyYg(end:-1:end-1));
          fill(xa,ya,'k');
        end
      end
      if ~isempty(ekind1), % labels of edges (arrows)
        if we==3,
          s=sprintf(ekind1,E2(k+k2-1,5));
        else
          s=sprintf(ekind1,E2(k+k2-1,2));
        end
        text(MyXg(length(MyXg)/2),MyYg(length(MyYg)/2),s);
%        set(hhh,'FontName','Times New Roman Cyr','FontSize',18)
      end
    end
    k=k+k1-1;
  end
  % we draw the loops
  k=0;
  ml=size(Ep,1); % number of loops
  while k<ml,
    k=k+1; % current loop
    MyV=V(Ep(k,3),1:2); % vertexes
    k1=1; % we find the multiple loops
    if k<ml,
      while all(Ep(k,3:4)==Ep(k+k1,3:4)),
        k1=k1+1;
        if k+k1>ml,
          break;
        end
      end
    end
    ry=[1:k1]+1; % radius
    for k2=1:k1, % we draw the loop
      MyX=xc*ry(k2)+MyV(1);
      MyY=(yc+r)*ry(k2)+MyV(2);
      plot(MyX,MyY,'k-');
      if kind1=='d',
        [xa,ya]=CreateArrow(MyX([1 10]),MyY([1 10]));
        fill(xa,ya,'k');
      end
      if ~isempty(ekind1), % labels of edges (arrows)
        if we==3,
          s=sprintf(ekind1,Ep(k+k2-1,5));
        else
          s=sprintf(ekind1,Ep(k+k2-1,2));
        end
        hhh=text(MyX(length(MyX)/2),MyY(length(MyY)/2),s);
%        set(hhh,'FontName','Times New Roman Cyr','FontSize',18)
      end
    end
    k=k+k1-1;
  end
end
hold off
axis off
if nargout==1,
  h=hh;
end
return

function [xa,ya]=CreateArrow(x,y)
% create arrow with length 0.1 with tip x(1), y(1) 
% and direction from x(2), y(2)

xa1=[0 0.1 0.08 0.1 0]';
ya1=[0 0.03 0 -0.03 0]';
dx=diff(x);
dy=diff(y);
alpha=atan2(dy,dx); % angle of rotation
cosa=cos(alpha);
sina=sin(alpha);
xa=xa1*cosa-ya1*sina+x(1);
ya=xa1*sina+ya1*cosa+y(1);
return