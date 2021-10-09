function prob = logist2ApplyRegularized(net, features)

prob = glmfwd(net, features')';
