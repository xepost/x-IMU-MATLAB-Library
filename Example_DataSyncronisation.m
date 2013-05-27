%% Example_DataSyncronisation.m
 
addpath('ximu_matlab_library'); % include library
close all;                      % close all figures
clear;                          % clear all variables
clc;                            % clear the command terminal
 
%% Synopsis
 
% Synchronisation requires that an event effecting all x-IMUs can be
% observed in the data of each x-IMU.  ExampleData_DataSyncronisation
% contains data logged from 2 x-IMUs sitting on a desk.  The desk was
% tapped 5 times at the start of the dataset and 5 times again at the end
% of the dataset.
%
% The SyncroniseData function is used to synchronise the data from the
% separate x-IMUs by specifying the time of the first tap observed within
% each x-IMU's data (as StartEvent).
%
% Minor drift between the clocks of each x-IMU may mean that data initially
% synchronised becomes out of sync after an extended period of time.  This
% can be corrected by specifying the time of the last tap observed within
% each x-IMU's data (as EndEvent).
 
%% Import data from directory
 
xIMUdataStruct = ImportDirectory('ExampleData_DataSyncronisation')
 
%% Manually synchronise data

% Inspect unsynchronised plots for values of startTimes and endTimes
xIMUdataStruct.ID_42EE.CalInertialMagneticData.Plot();
xIMUdataStruct.ID_42EF.CalInertialMagneticData.Plot();

% Specify event times and synchronise data
startTimes = [3.227 8.949];                 % observed times first tap prior to synchronisation
endTimes = [24.08 29.8];                   % observed times last tap prior to synchronisation (not necessary here)
xIMUdataStruct = SyncroniseData(xIMUdataStruct, 'StartEvent', startTimes, 'EndEvent', endTimes);
 
%% Plot synchronised data

figure('Name', 'Synchronised Accelerometer Data');
ax(1) = subplot(2,1,1);
hold on;
plot(xIMUdataStruct.ID_42EE.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EE.CalInertialMagneticData.Accelerometer.X, 'r');
plot(xIMUdataStruct.ID_42EE.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EE.CalInertialMagneticData.Accelerometer.Y, 'g');
plot(xIMUdataStruct.ID_42EE.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EE.CalInertialMagneticData.Accelerometer.Z, 'b');
legend('X', 'Y', 'Z');
xlabel('TIme (s)');
ylabel(strcat('Acceleration (g)'));
title('x-IMU 42EE - Accelerometer');
hold off;
ax(2) = subplot(2,1,2);
hold on;
plot(xIMUdataStruct.ID_42EF.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EF.CalInertialMagneticData.Accelerometer.X, 'r');
plot(xIMUdataStruct.ID_42EF.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EF.CalInertialMagneticData.Accelerometer.Y, 'g');
plot(xIMUdataStruct.ID_42EF.CalInertialMagneticData.Time, xIMUdataStruct.ID_42EF.CalInertialMagneticData.Accelerometer.Z, 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel(strcat('Acceleration (g)'));
title('x-IMU 42EF - Accelerometer');
hold off;
linkaxes(ax,'x');
 
%% End of script