function APT_interface
%% Identification
% David Krause
% Queen's University
% October 18, 2006
% Open a APT window, and populate it with controls

%% Start up...
button = questdlg('About to launch the APT window - do not run if another APT window is open.  Do you want to open the APT window?', ...
                  'Launch APT window', 'Yes', 'No', 'No');
if isempty(button)
	return
elseif length(button) == 2
	return
end

%% Parameters
ParamSet = 'DavidKrause'; % Name of the settings already defined using the APT User program

%% Create the interface
% Create the figure
fig = figure('Position', [5 35 1272 912], 'HandleVisibility', 'off', 'IntegerHandle', 'off', ...
             'Name', 'APT Interface', 'NumberTitle', 'off', 'DeleteFcn', 'APT_figure_delete_fcn');
         
set(fig, 'Name', ['APT Interface, Handle Number ' num2str(fig, '%2.20f')]);

%% Draw some annotations
annotation(fig, 'line', [0.505, 0.505], [0.05, 0.95])
annotation(fig, 'line', [0.5, 0.5], [0.05, 0.95])
annotation(fig, 'line', [0.495, 0.495], [0.05, 0.95])

%% Create the main control, ActiveX
% Consult the functions actxcontrolselect, actxcontrollist, methodsview
h_Ctrl = actxcontrol('MG17SYSTEM.MG17SystemCtrl.1', [0 0 100 100], fig);

% Start the control
h_Ctrl.StartCtrl;

% Prepare the user data
ud.h_Ctrl = h_Ctrl;
set(fig, 'UserData', ud);

%% Start the NanoTrak ActiveX controls
% Verify the number of NanoTrak units
[temp, num_nanotrak] = h_Ctrl.GetNumHWUnits(8, 0);
if num_nanotrak ~= 2
    fprintf(['Check number of NanoTraks (Found' num2str(num_nanotrak) ')!\n']);
    return
end

% Get the serial numbers
[temp, SN_nanotrak{1}] = h_Ctrl.GetHWSerialNum(8, 0, 0); % Get the serial number of the 1st device (index 0)
[temp, SN_nanotrak{2}] = h_Ctrl.GetHWSerialNum(8, 1, 0); % Get the serial number of the 2nd device (index 1)
SN_nanotrak % Check to see that these match with:
% 12345678 for the left module, and 12345678 for the right module (set to match to your SN)

% Place the left NanoTrak on the figure and configure
h_NanoTrak_Left = actxcontrol('MGNANOTRAK.MGNanoTrakCtrl.1', [0 640 600 272], fig);
SetNanoTrak(h_NanoTrak_Left, 12345678, ParamSet);

% Place the right NanoTrak on the figure and configure
h_NanoTrak_Right = actxcontrol('MGNANOTRAK.MGNanoTrakCtrl.1', [672 640 600 272], fig);
SetNanoTrak(h_NanoTrak_Right, 12345678, ParamSet);

% Prepare the user data
ud.h_NanoTrak_Left = h_NanoTrak_Left;
ud.h_NanoTrak_Right = h_NanoTrak_Right;
set(fig, 'UserData', ud);


%% Start the piezo ActiveX controls
% Verify the number of piezo controls
[temp, num_piezo] = h_Ctrl.GetNumHWUnits(7, 0);
if num_piezo ~= 4
    fprintf(['Check number of Piezo Controls (Found' num2tr(num_piezo) ')!\n']);
    return
end
% Get the serial numbers
for count = 1 : 4
    [temp, SN_piezo{count}] = h_Ctrl.GetHWSerialNum(7, count - 1, 0); % Get the serial number of the devices
end
SN_piezo
% Check to see that these match with:
% 12345678 (Left pitch roll), 12345678 (Left X Yaw), 12345678 (Right pitch roll), 12345678 (Right X Yaw)

% Start them up!
% Left Pitch and Roll
h_Piezo_LPitchRoll = actxcontrol('MGPIEZO.MGPiezoCtrl.1', [0 410 300 200], fig);
SetPiezo(h_Piezo_LPitchRoll, 12345678, ParamSet);

% Left X and Yaw
h_Piezo_LXYaw = actxcontrol('MGPIEZO.MGPiezoCtrl.1', [300 410 300 200], fig);
SetPiezo(h_Piezo_LXYaw, 12345678, ParamSet);

% Right Pitch and Roll
h_Piezo_RPitchRoll = actxcontrol('MGPIEZO.MGPiezoCtrl.1', [672 410 300 200], fig);
SetPiezo(h_Piezo_RPitchRoll, 12345678, ParamSet);

% Right X and Yaw
h_Piezo_RXYaw = actxcontrol('MGPIEZO.MGPiezoCtrl.1', [972 410 300 200], fig);
SetPiezo(h_Piezo_RXYaw, 12345678, ParamSet);

% Prepare the user data
ud.h_Piezo_LPitchRoll = h_Piezo_LPitchRoll;
ud.h_Piezo_LXYaw = h_Piezo_LXYaw;
ud.h_Piezo_RPitchRoll = h_Piezo_RPitchRoll;
ud.h_Piezo_RXYaw = h_Piezo_RXYaw;
set(fig, 'UserData', ud);


%% Start the motor controls
% Verify the number of motor controls
[temp, num_motor] = h_Ctrl.GetNumHWUnits(6, 0);
if num_motor ~= 6
    fprintf(['Check the number of Motor Controls (Found' num2str(num_motor) ')!\n']);
    return
end

% Get the serial numbers
for count = 1 : 6
    [temp, SN_motor{count}] = h_Ctrl.GetHWSerialNum(6, count - 1, 0); % Get the serial number of the devices
end
SN_motor
% Check to see that these match with:
% 12345678 (Left Pitch Roll), 12345678 (Left X Yaw), 12345678 (Left Y Z)
% 12345678 (Right Pitch Roll), 12345678 (Right X Yaw), 12345678 (Right Y Z)

% Start them up
% Left Pitch and Roll
h_Motor_LPitchRoll = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 205 300 200], fig);
SetMotor(h_Motor_LPitchRoll, 12345678, ParamSet);

% Left X and Yaw
h_Motor_LXYaw = actxcontrol('MGMOTOR.MGMotorCtrl.1', [300 205 300 200], fig);
SetMotor(h_Motor_LXYaw, 12345678, ParamSet);

% Left Y and Z
h_Motor_LYZ = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 0 300 200], fig);
SetMotor(h_Motor_LYZ, 12345678, ParamSet);

% Right Pitch and Roll
h_Motor_RPitchRoll = actxcontrol('MGMOTOR.MGMotorCtrl.1', [672 205 300 200], fig);
SetMotor(h_Motor_RPitchRoll, 12345678, ParamSet);

% Right X and Yaw
h_Motor_RXYaw = actxcontrol('MGMOTOR.MGMotorCtrl.1', [972 205 300 200], fig);
SetMotor(h_Motor_RXYaw, 12345678, ParamSet);

% Left Y and Z
h_Motor_RYZ = actxcontrol('MGMOTOR.MGMotorCtrl.1', [672 0 300 200], fig);
SetMotor(h_Motor_RYZ, 12345678, ParamSet);

% Prepare the user data
ud.h_Motor_LPitchRoll = h_Motor_LPitchRoll;
ud.h_Motor_LXYaw = h_Motor_LXYaw;
ud.h_Motor_LYZ = h_Motor_LYZ;

ud.h_Motor_RPitchRoll = h_Motor_RPitchRoll;
ud.h_Motor_RXYaw = h_Motor_RXYaw;
ud.h_Motor_RYZ = h_Motor_RYZ;

set(fig, 'UserData', ud);

%% Notify the user of the figure handle
fprintf(['APT Interface Created, Handle = ' num2str(fig, '%1.20f') '\n']);