function SetPiezo(h, SN, ParamSet)
% David Krause
% Queen's University
% October 18, 2006
% Set up the piezo controls

% Start the control
h.StartCtrl;

% Set the serial number
set(h, 'HWSerialNum', SN); pause(0.1);

% Identify the device
h.Identify;

% Load the parameters
h.LoadParamSet(ParamSet); pause(0.1);