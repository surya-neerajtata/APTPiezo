function SetNanoTrak(h, SN, ParamSet)
% David Krause
% Queen's University
% October 18, 2006
% Set up the NanoTrak controls


% Start the control
h.StartCtrl;

% Set the serial number
set(h, 'HWSerialNum', SN); pause(0.1);

% Make the light blink on the controller
h.Identify;

% Load the settings
h.LoadParamSet(ParamSet); pause(0.1);

% Set the circle diameter
h.SetCircDia(0); pause(0.1);

% Set the NanoTrak to Latch
h.Latch; pause(0.1);

% Set the position of the NanoTrak
h.SetCircHomePos(5, 5); 
h.MoveCircHome; pause(0.1);