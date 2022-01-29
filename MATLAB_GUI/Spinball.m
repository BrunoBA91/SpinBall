function varargout = Spinball(varargin)
% SPINBALL MATLAB code for Spinball.fig
%      SPINBALL, by itself, creates a new SPINBALL or raises the existing
%      singleton*.
%
%      H = SPINBALL returns the handle to a new SPINBALL or the handle to
%      the existing singleton*.
%
%      SPINBALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPINBALL.M with the given input arguments.
%
%      SPINBALL('Property','Value',...) creates a new SPINBALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Spinball_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Spinball_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Spinball

% HINTS: 
% contents = cellstr(get(hObject,'String')) returns TestsList contents as cell array
% contents{get(hObject,'Value')} returns selected item from TestsList
% UIWAIT makes Spinball wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% edit controls usually have a white background on Windows.
% See ISPC and COMPUTER.

% Last Modified by GUIDE v2.5 02-Nov-2018 11:42:03

% ---------------------------------------------------------------------- %
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spinball_OpeningFcn, ...
                   'gui_OutputFcn',  @Spinball_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% ---------------------------------------------------------------------- %

% --- Executes just before Spinball is made visible.
function Spinball_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

% Choose default command line output for Spinball
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Spinball.
if strcmp(get(hObject,'Visible'),'off')
    [I, ~, ImageAlpha] = imread('crc.png');
    image(I, 'AlphaData', ImageAlpha);
end


% --- Outputs from this function are returned to the command line.
function varargout = Spinball_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Update_Figure.
function Update_Figure_Callback(hObject, eventdata, handles)
% We update the plot
axes(handles.Curve); cla; Draw_Plot();


% --------------------------------------------------------------------
% function FileMenu_Callback(hObject, eventdata, handles)
% % hObject    handle to FileMenu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% This function opens the GUI
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
% function PrintMenuItem_Callback(hObject, eventdata, handles)
% % This function prints the plot
% printdlg(handles.figure1)

% --------------------------------------------------------------------
%function CloseMenuItem_Callback(hObject, eventdata, handles)
% % hObject    handle to CloseMenuItem (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
%                      ['Close ' get(handles.figure1,'Name') '...'],...
%                      'Yes','No','Yes');
% if strcmp(selection,'No')
%     return;
% end
% delete(handles.figure1)


% --- Executes on button press in Open_Figure_Outside_GUI.
function Open_Figure_Outside_GUI_Callback(hObject, eventdata, handles)
% We open the figure outside the GUI for detailed inspection
figure; Draw_Plot(hObject, eventdata, handles);


% --- Executes on button press in Store_Figure_Values.
function Store_Figure_Values_Callback(hObject, eventdata, handles)
% We store the values of the curve into a file
TP = evalin('base', 'TP'); TP = TP';
Ct = evalin('base', 'Ct'); Ct = Ct';
writetable(table(TP,Ct),uiputfile('*.xls'));


% --- Executes on button press in Auto.
function Auto_Callback(hObject, eventdata, handles)
% Curve is updated continuously inside a loop
flag = evalin('base', 'flag'); flag = 0; assignin('base','flag',flag);
while flag == 0
    Show_Callback(hObject, eventdata, handles);
    Draw_Plot(hObject, eventdata, handles);
    flag = evalin('base', 'flag');
end


% --- Executes on button press in Manual.
function Manual_Callback(hObject, eventdata, handles)
% We exit the loop that continuously plots the Curve
flag = evalin('base', 'flag'); flag = 1; assignin('base','flag',flag);
  

% --- Executes on selection change in TestsList.
function TestsList_Callback(hObject, eventdata, handles)
% We print all the files in the path selected from the user
  Files = ls('*.txt');
  set(handles.TestsList,'String',Files);

% --- Executes during object creation, after setting all properties.
function TestsList_CreateFcn(hObject, eventdata, handles)
% We set the color of the background
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% We clear all the listbox
  set(handles.TestsList,'String',[]);
  set(handles.Path, 'String', []);

% --- Executes on button press in Show.
function Show_Callback(hObject, eventdata, handles)
% We show all the files in the current directory
  TestsList_Callback(hObject, eventdata, handles);
  Path_Callback(pwd,eventdata,handles);
return

% --- Executes on button press in Select Path.
function NewPath = Select_Path_Callback(hObject, eventdata, handles)
% We ask the user for the current path
  NewPath = uigetdir('C:\'); 
  Path_Callback(NewPath,eventdata,handles); cd(NewPath); %savepath(NewPath);
  TestsList_Callback(NewPath, eventdata, handles);
return

function Path_Callback(hObject, eventdata, handles)
% We print the current path in the GUI
  set(handles.Path, 'String', hObject);


% --- Executes during object creation, after setting all properties.
function Path_CreateFcn(hObject, eventdata, handles)
% We set the Background color for the window path
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function TestsList_KeyPressFcn(hObject, eventdata, handles)
% % hObject    handle to Path (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

function Draw_Plot(hObject, eventdata, handles)
% Read the data
    warning ('off','all');
    clear all; clc;
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
    
    % Saving variables to workspace
    assignin('base','TP',x); 
    assignin('base','Ct',y);

    % Plot the data
    hs = gscatter(x,y,g,'br','oo'); line(x,y);
    hleg = legend('hs'); set(hleg,'visible','off');

    % Plot properties
    grid on; 
    xlabel('Thromboplastine (ul)'); ylabel('Clotting time (s)');
    title('Ct vs TP');
    set(gca, 'XScale', 'log');
    pause(0.5);
    
    
