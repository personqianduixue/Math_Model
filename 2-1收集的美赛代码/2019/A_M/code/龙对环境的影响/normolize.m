function [ pre_normal,sta_normal ] = normolize(pre_ori,sta_ori)
%% normalized
% normalize the raw data of the dragon's stress on the environment
pre_normal = (pre_ori-min(pre_ori))/(max(pre_ori)-min(pre_ori));
% environmental state raw data normalization
sta_normal = (sta_ori-max(sta_ori))/(min(sta_ori)-max(sta_ori));
end

