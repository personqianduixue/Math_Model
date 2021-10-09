function hText = rotate_xlabel(degrees, newlabels)

% Posted to comp.soft-sys.matlab on 2003-05-01 13:45:36 PST 
% by David Borger (borger@ix.netcom.com)

xtl = get(gca,'XTickLabel');
set(gca,'XTickLabel','');
lxtl = length(xtl);
xtl = newlabels;
if 0 % nargin>1
    lnl = length(newlabels);
    if lnl~=lxtl
        error('Number of new labels must equal number of old');
    end;
    xtl = newlabels;
end;


hxLabel=get(gca,'XLabel');
xLP=get(hxLabel,'Position');
y=xLP(2);
XTick=get(gca,'XTick');
y=repmat(y,length(XTick),1);
%fs=get(gca,'fontsize');
fs = 12;
hText=text(XTick,y,xtl,'fontsize',fs);
set(hText,'Rotation',degrees,'HorizontalAlignment','right');

% Modifications by KPM

ylim = get(gca,'ylim');
height = ylim(2)-ylim(1);
N = length(hText);
for i=1:N
  voffset = ylim(2) - 0*height;
  set(hText(i), 'position', [i voffset 0]);
end
