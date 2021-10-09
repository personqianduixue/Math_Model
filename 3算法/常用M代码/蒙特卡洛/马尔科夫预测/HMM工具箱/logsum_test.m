p1 = log(1e-5);
p2 = log(5*1e-6);
p3 = log(sum(exp([p1 p2])))
p4 = logsumexp([p1 p2],2)
p5 = logsum([p1 p2])
p6 = logsum([p1 p2])
