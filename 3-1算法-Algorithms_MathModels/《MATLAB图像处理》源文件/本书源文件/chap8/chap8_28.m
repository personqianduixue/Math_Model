

clear all; close all;
I=imread('gantrycrane.png');
I=rgb2gray(I);
BW=edge(I, 'canny');
[H, Theta, Rho]=hough(BW, 'RhoResolution', 0.5, 'Theta', -90:0.5:89.5);
P=houghpeaks(H, 5, 'threshold', ceil(0.3*max(H(:))));
x=Theta(P(:, 2));
y=Rho(P(:, 1));
figure;
set(0,'defaultFigurePosition',[100,100,1000,500]);
set(0,'defaultFigureColor',[1 1 1])
subplot(121);
imshow(imadjust(mat2gray(H)), 'XData', Theta, 'YData', Rho,...
    'InitialMagnification', 'fit');
axis on; 
axis normal;
hold on;
plot(x, y, 's', 'color', 'white');
lines=houghlines(BW, Theta, Rho, P, 'FillGap', 5, 'MinLength', 7);
subplot(122);
imshow(I);
hold on;
maxlen=0;
for k=1:length(lines)
    xy=[lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:, 2), 'linewidth', 2, 'color', 'green');
    plot(xy(1,1), xy(1, 2), 'linewidth', 2,  'color', 'yellow');
    plot(xy(2,1), xy(2, 2), 'linewidth', 2,  'color', 'red');
    len=norm(lines(k).point1-lines(k).point2);
    if (len>maxlen)
        maxlen=len;
        xylong=xy;
    end
end
hold on;
plot(xylong(:, 1), xylong(:, 2), 'color', 'blue');

