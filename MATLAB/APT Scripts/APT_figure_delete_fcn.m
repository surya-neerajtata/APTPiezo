function APT_figure_delete_fcn
%% Identification
% David Krause
% Queen's University
% October 18, 2006
% Clean up that APT window

%% Get the UserData
ud = get(gcbo, 'UserData');

%% Clean up the objects
% Clean up the NanoTraks
try
    ud.h_NanoTrak_Left.StopCtrl;
    ud.h_NanoTrak_Left.delete;
    ud.h_NanoTrak_Right.StopCtrl;
    ud.h_NanoTrak_Right.delete;
catch
    fprintf('Tried to close and delete NanoTrak controls, problem!\n');
end

% Clean up the piezos
try
    ud.h_Piezo_LPitchRoll.StopCtrl;
    ud.h_Piezo_LPitchRoll.delete;
    ud.h_Piezo_LXYaw.StopCtrl;
    ud.h_Piezo_LXYaw.delete;

    ud.h_Piezo_RPitchRoll.StopCtrl;
    ud.h_Piezo_RPitchRoll.delete;
    ud.h_Piezo_RXYaw.StopCtrl;
    ud.h_Piezo_RXYaw.delete;
catch
    fprintf('Tried to close and delete Piezo controls, problem!\n');
end

% Clean up the motors
try
    ud.h_Motor_LPitchRoll.StopCtrl;
    ud.h_Motor_LPitchRoll.delete;
    ud.h_Motor_LXYaw.StopCtrl;
    ud.h_Motor_LXYaw.delete;
    ud.h_Motor_LYZ.StopCtrl;
    ud.h_Motor_LYZ.delete;
    
    ud.h_Motor_RPitchRoll.StopCtrl;
    ud.h_Motor_RPitchRoll.delete;
    ud.h_Motor_RXYaw.StopCtrl;
    ud.h_Motor_RXYaw.delete;
    ud.h_Motor_RYZ.StopCtrl;
    ud.h_Motor_RYZ.delete;
catch
    fprintf('Tried to close and delete Motor controls, problem!\n');
end



% Clean up the main control
try
    ud.h_Ctrl.StopCtrl;
    ud.h_Ctrl.delete
catch
    fprintf('Tried to close the main APT control, problem!\n');
end

fprintf('APT Interface Closed.\n');