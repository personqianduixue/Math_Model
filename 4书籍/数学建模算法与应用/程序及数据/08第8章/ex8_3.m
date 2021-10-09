clc,clear
yt=load('fadian.txt');  %原始发电总量数据以列向量的方式存放在纯文本文件中
n=length(yt), alpha=0.3; st1(1)=yt(1); st2(1)=yt(1);
for i=2:n
    st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1);
    st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1);
end
xlswrite('fadian.xls',[st1',st2']) %把数据写入表单Sheet1中的前两列
at=2*st1-st2;
bt=alpha/(1-alpha)*(st1-st2);
yhat=at+bt;  %最后的一个分量为1986年的预测值
xlswrite('fadian.xls',yhat','Sheet1','C2') %把预测值写入第3列
str=['C',int2str(n+2)]; %准备写1987年预测值位置的字符串
xlswrite('fadian.xls',at(n)+2*bt(n),'Sheet1',str)%把1987年预测值写到相应位置
