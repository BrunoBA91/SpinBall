warning ('off','all');
%while true    
    clear all; clc;

    % Read the data
    files = dir('*.txt');
    F = {files.name}; M = zeros(3,size(F,2));
    for i = 1:size(F,2)
        date = str2double(cell2mat(extractBetween(F{i},"__",".txt")));
        col = [dlmread(F{i},':',[1 1 2 1]); date];
        if col(2) == 0; col(2) = 0.001; end
        M(:,i) = col;
    end

    % Prepare data
    x = sort(M(2,:),'descend'); 
    y = sort(M(1,:));
    g = double(M(3,:) == max(M(3,:)));

    % Plot the data
    h = gscatter(x,y,g,'br','oo'); line(x,y);
    hleg = legend('h'); set(hleg,'visible','off');

    % Plot properties
    grid on; 
    xlabel('Thromboplastine (ul)'); ylabel('Clotting time (s)');
    title('Ct vs TP');
    set(gca, 'XScale', 'log');
    pause(0.5);
%end
