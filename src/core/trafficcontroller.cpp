#include "trafficcontroller.h"
#include  <random>



trafficcontroller::trafficcontroller():gen(rdevice),distrib(1,4) {

}

int trafficcontroller::randomNumber(int min, max)
{
    return distrib(gen);
}
