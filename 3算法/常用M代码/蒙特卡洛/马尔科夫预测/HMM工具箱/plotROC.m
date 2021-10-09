function [falseAlarmRate, detectionRate, area, th] = plotROC(confidence, testClass, col, varargin)
% function [falseAlarmRate, detectionRate, area, th] = plotroc(confidence, testClass, color)

if nargin < 3, col = []; end

[scale01] = process_options(varargin, 'scale01', 1);

[falseAlarmRate detectionRate area th] = computeROC(confidence, testClass);

if ~isempty(col)
    h=plot(falseAlarmRate, detectionRate, [col '-']);
    %set(h, 'linewidth', 2);
    ex = 0.05*max(falseAlarmRate);
    ey = 0.05;
    if scale01
      axis([0-ex max(falseAlarmRate)+ex 0-ey 1+ey])
    else
      % zoom in on the top left corner
      axis([0-ex max(falseAlarmRate)*0.5+ex 0.5-ey 1+ey])
    end
    grid on
    ylabel('detection rate')
    %xlabel('# false alarms')
    xlabel('false alarm rate')
end

