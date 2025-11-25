#ifndef TRAFFICCONTROLLER_H
#define TRAFFICCONTROLLER_H
#include <random>

class trafficcontroller
{
private :
    std::random_device rdevice;
    std::mt19937 gen;
    std::uniform_int_distribution <> distrib;
public:

    trafficcontroller();
    int randomNumber(int min,max);
};

#endif // TRAFFICCONTROLLER_H
