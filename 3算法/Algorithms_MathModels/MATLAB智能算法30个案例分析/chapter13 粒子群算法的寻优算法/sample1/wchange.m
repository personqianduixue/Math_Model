ws=0.9;
we=0.4;
maxgen=300;
hold on;

for k = 1:maxgen
    w(k)=ws-(ws-we)*(k/maxgen);
end
plot(w);

for k = 1:maxgen
    w(k)=ws-(ws-we)*(k/maxgen)^2;
end
plot(w,'r');

for k = 1:maxgen
    w(k)=ws-(ws-we)*(2*k/maxgen-(k/maxgen)^2);
end
plot(w,'g');

for k = 1:maxgen
    w(k)=we*(ws/we)^(1/(1+10*k/maxgen));
end
plot(w,'y');

