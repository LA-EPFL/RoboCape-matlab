% Initialise ROS on remote master (Beaglebone IP)
setenv('ROS_MASTER_URI','http://192.168.7.2:11311')
setenv('ROS_IP','192.168.7.1')
rosinit

hover_pub = rospublisher('/hovercraft/actuator_hover_update',rostype.std_msgs_Float64)
hover_msg = rosmessage(hover_pub);

rudder_pub = rospublisher('/hovercraft/actuator_rudder_update',rostype.std_msgs_Float64)
rudder_msg = rosmessage(rudder_pub);

for i=1:100
    for k=[0,10]
        hover_msg.Data = k / 10;
        rudder_msg.Data = -1 + k / 5;

        send(hover_pub, hover_msg)
        send(rudder_pub, rudder_msg)

        pause(1)
    end
end

rosshutdown
