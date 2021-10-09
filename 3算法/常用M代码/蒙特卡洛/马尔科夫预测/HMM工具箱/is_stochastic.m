function p = is_stochastic(T)
% IS_STOCHASTIC Is the argument a stochastic matrix, i.e., the sum over the last dimension is 1.
% p = is_stochastic(T)

p = approxeq(T, mk_stochastic(T));
