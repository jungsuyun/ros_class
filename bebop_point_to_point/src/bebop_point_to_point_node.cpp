#include "Altitude.h"
#include "Bearing.h"
#include <iostream>

int main(int argc, char** argv)
{
    double target_altitude = 5;
    double target_latitude = 48.8790319;
    double target_longitude = 2.3680586;

    Altitude altitude = Altitude(argc, argv);

    altitude.move_to_target_altitude(target_altitude);

    std::cout <<"finished" << std::endl;

    return 0;
}
