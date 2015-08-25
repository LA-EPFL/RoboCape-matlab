close all; clear all; clc;

PC_IP = '192.168.7.1';
BEAGLEBONE_IP = 'http://192.168.7.2';
PLOT_INTERVAL = 500;

% Initialise ROS on remote master
setenv('ROS_MASTER_URI', strcat(BEAGLEBONE_IP, ':11311'))
setenv('ROS_IP', PC_IP)
rosinit

sub = rossubscriber('/hovercraft/imu_readings', rostype.sensor_msgs_Imu);

figure(1); hold on;
cnt = 0; T = []; X = []; Y = []; Z = [];
while 1
    imu_reading = receive(sub);
    time = rostime('now');

    if cnt < PLOT_INTERVAL
        T = [T cnt];
        X = [X imu_reading.LinearAcceleration.X];
    else
        T = [T(2:end) cnt];
        X = [X(2:end) imu_reading.LinearAcceleration.X];
        axis([cnt - PLOT_INTERVAL, cnt, -inf, inf])
    end
    cnt = cnt + 1;

    plot(T, X, 'r')
    legend('X acc')
end
