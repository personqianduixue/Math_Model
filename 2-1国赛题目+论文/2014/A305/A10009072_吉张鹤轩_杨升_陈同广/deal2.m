cd('./');
A = imread('附件4 距月面100m处的数字高程图.tif');

N = 100;
n = 1000 / N;
data = zeros(N,N);
[height, length] = size(data);
for i = 1:1:height
    for j = 1:1:length
        data(i,j) = sum(sum(A(round(n*(i-1)+1):round(n*i)-(round(n*i)>2300), round(n*(j-1)+1):round(n*j)-(round(n*j)>2300))))/ round(n*n);
    end
end
data = uint8(round(data));

%imshow(data);

%第二阶段
%分析斜度
yuzumi = double(zeros(N,N));
N2 = 50;
n2 = 1000/N2;
ana_width = n2+10;
for i = 1:1:N2
    for j = 1:1:N2
        X = [];
        z = [];
        for x = max((i-1)*n2+1-(ana_width-n2), 1):1:min(i*n2+(ana_width-n2), 1000)
            for y = max((j-1)*n2+1-(ana_width-n2), 1):1:min(j*n2+(ana_width-n2), 1000)
                X = [X; 1, x, y];
                z = [z; double(A(x,y))];
            end
        end
        b = regress(z,X);
        arc = [b(2), b(3), 1];
        sita = acos(dot(arc,[0 0 1])/sqrt(dot(arc,arc)));
        yuzumi((i-1)*(N/N2)+1:i*(N/N2), (j-1)*(N/N2)+1:j*(N/N2)) = sita;
    end
end
heion = (max(max(yuzumi)) - yuzumi)/max(max(yuzumi));
%surface(heion,'EdgeColor','none');

%聚类分析
data3 = [];
for i = 1:1:N
    for j = 1:1:N
        data3 = [data3; data(i,j)];
    end
end
[Idx,C,sumD,D]=kmeans(double(data3),4);
C(1,3) = sum(C(:,1) < C(1,1)); C(1,2) = sum(Idx == 1);
C(2,3) = sum(C(:,1) < C(2,1)); C(2,2) = sum(Idx == 2);
C(3,3) = sum(C(:,1) < C(3,1)); C(3,2) = sum(Idx == 3);
C(4,3) = sum(C(:,1) < C(4,1)); C(4,2) = sum(Idx == 4);
GND = sum(C(:,3) .* (C(:,2) == max(C(:,2))));
data4 = zeros(N, N);
for i = 1:1:N
    for j = 1:1:N
        data4(i,j) = C(Idx((i-1)*N + j), 3);
    end
end
%surface(data4,'EdgeColor','none');

%第三个阶段选择合适区域
data2 = 1- (data4 == GND);

score = zeros(N, N);
for i = 1:1:height
    for j = 1:1:length
        if (data2(i,j) == 0)
            tmp = 1;
            while (tmp<=i && tmp<=N-i+1 && tmp<=j && tmp<= N-j+1 && sum(sum(data2(i-tmp+1:i+tmp-1, j-tmp+1:j+tmp-1))) == 0)
                tmp = tmp + 1;
            end
            tmp = tmp - 1;
            score(i,j) = tmp; %.* heion(i,j);
        end
    end
end
%surface(score,'EdgeColor','none');