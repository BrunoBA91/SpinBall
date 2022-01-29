%%%%% Stock Pulley Profile Extraction %%%%%
clear all; close all; clc;

% We will start by reading the image with its transparency backgroung
I1 = imread('Stock_Pulley_Profile_GS.png');
I1 = double(I1);
I1b = imbinarize(I1);
I1bn = I1b < 1;
%f1 = imshow(I1);
%set(f1, 'AlphaData', alpha);


% New Matrix (mean of all the others)
angle = 11.25;
Imean = I1;
for i = 0:33
    In = imrotate(I1bn,angle*i,'nearest','crop'); 
    Imean = (Imean + In)/2;
end
figure; 
imshowpair(Imean,I1bn,'montage');


%% Other tests
clear all; close all; clc;
I = imread('GearMaskDidac.jpeg');
I = double(rgb2gray(I));
[nI,h] = imcontour(I,1);
s = contourdata(nI);

%% Plotting the contours as X-Y values
close all;
%imcontour(I,1); hold on;
plot(s(1).xdata,s(1).ydata,'k'); hold on; % 1
% %plot(s(2).xdata,s(2).ydata,'r'); 
plot(s(3).xdata,s(3).ydata,'k');          % 3
plot(s(4).xdata,s(4).ydata,'k');          % 4
% %plot(s(5).xdata,s(5).ydata,'r'); 
% %plot(s(6).xdata,s(6).ydata,'r');
plot(s(7).xdata,s(7).ydata,'k');          % 7
plot(s(8).xdata,s(8).ydata,'k');          % 8
%plot(s(9).xdata,s(9).ydata,'r');
%set(gca,'Visible','off');
% x0=0;
% y0=0;
% width=1763.7;
% height=1763.7;
% set(gcf,'units','points','position',[x0,y0,width,height])

%% Extracting the X-Y points
a = [s(1).xdata,s(1).ydata];
b = [s(3).xdata,s(3).ydata];
c = [s(4).xdata,s(4).ydata];
d = [s(7).xdata,s(7).ydata];
e = [s(8).xdata,s(8).ydata];
xypoints = [a;b;c;d;e];
xypoints = [xypoints,zeros(size(xypoints,1),1)];
csvwrite('a.xyz',a); csvwrite('b.xyz',b); csvwrite('c.xyz',c);
csvwrite('d.xyz',d); csvwrite('e.xyz',e); csvwrite('xypoints.xyz',xypoints);
save('a.txt', 'a', '-ascii', '-double', '-tabs');
save('b.txt', 'b', '-ascii', '-double', '-tabs');
save('c.txt', 'c', '-ascii', '-double', '-tabs');
save('d.txt', 'd', '-ascii', '-double', '-tabs');
save('e.txt', 'e', '-ascii', '-double', '-tabs');
save('xypoints.txt', 'xypoints', '-ascii', '-double', '-tabs');


%% Spline
% x = s(1).xdata;
% y = s(1).ydata;
% xx = 695:.05:780;
% yy = spline(x,y,xx);
% plot(x,y,'o',xx,yy)