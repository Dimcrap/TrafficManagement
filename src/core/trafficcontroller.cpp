#include "trafficcontroller.h"
#include  <QRandomGenerator>


trafficcontroller::trafficcontroller(){

}

int trafficcontroller::randomNumber(int min, int max)
{
    return QRandomGenerator::global()->bounded(min,max+1);
}
