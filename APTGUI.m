clear;
close all;
clc;
global h; % make h a global variable so it can be used outside the main
          % function. Useful when you do event handling and sequential           move

%% Create Matlab Figure Container
fpos    = get(0,'DefaultFigurePosition'); % figure default position
fpos(3) = 650; % figure window size;Width
fpos(4) = 450; % Height
 
f = figure('Position', fpos,...
           'Menu','None',...
           'Name','APT GUI');
%% Create ActiveX Controller
h = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);
 
%% Initialize
% Start Control
h.StartCtrl;
 
% Set the Serial Number
SN = 45822682; % put in the serial number of the hardware
set(h,'HWSerialNum', SN);
 
% Indentify the device
h.Identify;
