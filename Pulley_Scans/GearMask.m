%%%%% Gear Mask %%%%%
clear all; close all; clc;
I = imread('Gear2Cleaned_contour.png');
I = double(rgb2gray(I));
[nI,h] = imcontour(I,1);
s = contourdata(nI);

%% Plotting the contours as X-Y values
close all;
imcontour(I,1); hold on;
%plot(s(1).xdata,s(1).ydata,'r'); hold on; 
plot(s(2).xdata,s(2).ydata,'r');           % 2
plot(s(3).xdata,s(3).ydata,'r');           % 3
%plot(s(4).xdata,s(4).ydata,'r');          
%plot(s(5).xdata,s(5).ydata,'r'); 
plot(s(6).xdata,s(6).ydata,'r');           % 6
plot(s(7).xdata,s(7).ydata,'r');           % 7
%plot(s(8).xdata,s(8).ydata,'r');          
%plot(s(9).xdata,s(9).ydata,'r');
%plot(s(10).xdata,s(10).ydata,'r');
%plot(s(11).xdata,s(11).ydata,'r');
%plot(s(12).xdata,s(12).ydata,'r');
%plot(s(13).xdata,s(13).ydata,'r');
set(gca,'Visible','off');

% %% Extracting the X-Y points
% a = [s(2).xdata,s(2).ydata]; a = [a,zeros(size(a,1),1)];
% b = [s(3).xdata,s(3).ydata]; b = [b,zeros(size(b,1),1)];
% c = [s(6).xdata,s(6).ydata]; c = [c,zeros(size(c,1),1)];
% d = [s(7).xdata,s(7).ydata]; d = [d,zeros(size(d,1),1)];
% xypoints = [a;b;c;d];
% xypoints = [xypoints,zeros(size(xypoints,1),1)];
% csvwrite('a.xyz',a); csvwrite('b.xyz',b); csvwrite('c.xyz',c);
% csvwrite('d.xyz',d); csvwrite('xypoints.xyz',xypoints);
% save('a.txt', 'a', '-ascii', '-double', '-tabs');
% save('b.txt', 'b', '-ascii', '-double', '-tabs');
% save('c.txt', 'c', '-ascii', '-double', '-tabs');
% save('d.txt', 'd', '-ascii', '-double', '-tabs');
% save('xypoints.txt', 'xypoints', '-ascii', '-double', '-tabs');