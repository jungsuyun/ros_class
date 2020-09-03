#include "BebopSub.h"
#include <iostream>

int main(int argc, char** argv)
{
    BebopSub bebopSub = BebopSub(argc, argv);
    bebopSub.init(5.0);
    std::cout << "Reached to Target altitude.. system exit" << std::endl;

    return 0;
}
