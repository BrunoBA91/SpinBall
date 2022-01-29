clear all; clc; close all;

%%%%% Magnetic Field Force Computation %%%%%

nu0 = 4*pi*(10^-7);        % Magnetic permeability of free space in N·A^-2
R = 0.004;               % Magnet radius in meters
L = 0.003;               % Magnet width in meters
m = 1.1;                 % Magnet mass in grams
Br = (1.17:0.01:1.37);   % Residual flux density interval [1.17-1.37] in T (1T = 1N/A·m)
x = (0.008:0.0001:0.05); % Vector of distances
percent = 4.08;           % Percent of maximum Force permissible

for i = 1.17:0.01:1.37
    % Computing the magnetization M based on Br in A/m:
    M = (1/nu0)*i;
    % Computing the final Force F in N between magnets:
    F = (pi*nu0*(M.^2)*(R^4)/4)*((1./x)+(1./(x+2*L).^2)-(2./(x+L).^2));
    plot(x*1000,-F,'Color',[rand rand rand]);
    hold on; xlim([8 50]);
    ylabel('Force between magnets (N)'); xlabel('Center-to-Center Distance (mm)');
    h = vline(x(size(F(F <= (percent/100)*min(F)),2))*1000,'g');
end 

% %%%%% Cylinder Magnet Flux Density %%%%%
% figure;
% 
% z = 0;                   % Distance from a pole face on the symmetrical axis in meters
% D = (0.003:0.001:0.03);  % Width interval of the cylinder in meters
% 
% for i = 1.17:0.01:1.37
%     % Computing the Magnet Flux Density in T:
%     B = (i/2)*(((D+z)./sqrt((R^2)+(D+z).^2))-(z/(sqrt((R^2)+(z^2)))));
%     plot(D*1000,B,'Color',[rand rand rand]);
%     hold on; xlim([3 30]);
%     ylabel('B (T)'); xlabel('Magnet Width D (mm)');
% end


%%%%% Magnetic force to a 2mm diameter ball in terms of excentricity %%%%%
