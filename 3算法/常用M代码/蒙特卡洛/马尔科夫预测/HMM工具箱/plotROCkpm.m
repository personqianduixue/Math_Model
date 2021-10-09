function [falseAlarmRate, detectionRate, area, th] = plotROC(confidence, testClass, col, varargin)
% You pass the scores and the classes, and the function returns the false
% alarm rate and the detection rate for different points across the ROC.
%
% [faR, dR] = plotROC(score, class)
%
%  faR (false alarm rate) is uniformly sampled from 0 to 1
%  dR (detection rate) is computed using the scores.
%
% class = 0 => target absent
% class = 1 => target present
%
% score is the output of the detector, or any other measure of detection.
% There is no plot unless you add a third parameter that is the color of
% the graph. For instance:
% [faR, dR] = plotROC(score, class, 'r')
%
% faR, dR are size 1x1250

if nargin < 3, col = []; end
[scale01] = process_options(varargin, 'scale01', 1);

S = rand('state');
rand('state',0);
confidence = confidence + rand(size(confidence))*10^(-10);
rand('state',S)

ndxAbs = find(testClass==0); % absent
ndxPres = find(testClass==1); % present

[th, j] = sort(confidence(ndxAbs));
th = th(fix(linspace(1, length(th), 1250))); 

cAbs = confidence(ndxAbs);
cPres = confidence(ndxPres);
for t=1:length(th)
  if length(ndxPres) == 0
    detectionRate(t) = 0;
  else
    detectionRate(t)  = sum(cPres>=th(t)) / length(ndxPres);
  end
  if length(ndxAbs) == 0
    falseAlarmRate(t) = 0;
  else
    falseAlarmRate(t) = sum(cAbs>=th(t)) / length(ndxAbs);
  end
  
  %detectionRate(t)  = sum(confidence(ndxPres)>=th(t)) / length(ndxPres);
  %falseAlarmRate(t) = sum(confidence(ndxAbs)>=th(t)) / length(ndxAbs);
  %detections(t)     = sum(confidence(ndxPres)>=th(t));
  %falseAlarms(t)    = sum(confidence(ndxAbs)>=th(t));
end

area = sum(abs(falseAlarmRate(2:end) - falseAlarmRate(1:end-1)) .* detectionRate(2:end));

if ~isempty(col)
    h=plot(falseAlarmRate, detectionRate, [col '-']);
    %set(h, 'linewidth', 2);
    e = 0.05;
    if scale01
      axis([0-e 1+e 0-e 1+e])
    else
      % zoom in on the top left corner
      axis([0-e 0.5+e 0.5-e 1+e])
    end
    grid on
    ylabel('detection rate')
    xlabel('false alarm rate')
end
