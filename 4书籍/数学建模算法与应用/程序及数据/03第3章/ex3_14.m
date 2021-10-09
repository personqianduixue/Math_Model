options=optimset('GradObj','on','GradConstr','on');
[x,y]=fmincon(@fun10,rand(2,1),[],[],[],[],[],[],@fun11,options)
