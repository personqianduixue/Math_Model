function y = predict1(t)
    global a1 b1 K1
    y = K1 + a1*b1.^t;
end