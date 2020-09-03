#ifndef BEBOP_POINT_TO_POINT_BEBOPSUB_H
#define BEBOP_POINT_TO_POINT_BEBOPSUB_H

#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <bebop_msgs/Ardrone3PilotingStateAltitudeChanged.h>

class BebopSub
{
private:
    ros::Subscriber altitude_sub;
    ros::Publisher cmd_pub;

    double current_altitude;

    int init_argc;
    char** init_argv;
    ros::Duration rate;

public:
    BebopSub(int argc, char** argv);
    void init(double target_altitude);
    void altitudeCallback(const bebop_msgs::Ardrone3PilotingStateAltitudeChanged::ConstPtr& msg);
};


#endif //BEBOP_POINT_TO_POINT_BEBOPSUB_H
