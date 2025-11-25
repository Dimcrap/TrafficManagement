#ifndef TRAFFICCONTROLLER_H
#define TRAFFICCONTROLLER_H
#include <QObject>

class trafficcontroller:public QObject
{
    Q_OBJECT
public:
    trafficcontroller();
    Q_INVOKABLE int randomNumber(int min,int max);
};

#endif // TRAFFICCONTROLLER_H
