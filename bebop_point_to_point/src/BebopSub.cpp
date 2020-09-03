#include "BebopSub.h"
#include <math.h>

BebopSub::BebopSub(int argc, char **argv)
{
    this->init_argc = argc;
    this->init_argv = argv;

    this->rate = ros::Duration(0.1);
}

void BebopSub::init(double target_altitude)
{
    ros::init(init_argc, init_argv, "bebop_P2P");
    ros::NodeHandle nh;

    this->altitude_sub = nh.subscribe("/bebop/states/ardrone3/PilotingState/AltitudeChanged", 1, &BebopSub::altitudeCallback, this);
    this->cmd_pub = nh.advertise<geometry_msgs::Twist>("/bebop/cmd_vel", 1);

    while(ros::ok())
    {
        try
        {
            ros::spinOnce();
        }
        catch (...)
        {
            ROS_ERROR("spin error!");
        }
        // 드론이 상승을 해야하는 경우 or 하강해야 해야 하는 경우 or 정지 하는 경우
        if(target_altitude - this->current_altitude > 0.1)
        {
            ROS_INFO("going up : %f", target_altitude - current_altitude);
            geometry_msgs::Twist twist;
            twist.linear.x = twist.linear.y = 0;
            twist.angular.x = twist.angular.y = twist.angular.z = 0;
            twist.linear.z = 0.3;

            cmd_pub.publish(twist);
        }
        else if(target_altitude - this->current_altitude < -0.1)
        {
            ROS_INFO("going down : %f", target_altitude - current_altitude);
            geometry_msgs::Twist twist;
            twist.linear.x = twist.linear.y = 0;
            twist.angular.x = twist.angular.y = twist.angular.z = 0;
            twist.linear.z = -0.3;

            cmd_pub.publish(twist);
        }

        else
        {
            ROS_INFO("going down : %f. stop", target_altitude - current_altitude);
            geometry_msgs::Twist twist;
            twist.linear.x = twist.linear.y = twist.linear.z = 0;
            twist.angular.x = twist.angular.y = twist.angular.z = 0;

            cmd_pub.publish(twist);
            break;
        }
    }
}

void BebopSub::altitudeCallback(const bebop_msgs::Ardrone3PilotingStateAltitudeChanged::ConstPtr &msg)
{
    this->current_altitude = msg->altitude;
}
