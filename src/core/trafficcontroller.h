#ifndef TRAFFICCONTROLLER_H
#define TRAFFICCONTROLLER_H
#include <QObject>
#include <QTimer>

class trafficcontroller:public QObject
{
    Q_OBJECT
private:
    QTimer *m_timer;
    int m_remainvehicles;

public:
    trafficcontroller(QObject *parent =nullptr);
    Q_INVOKABLE int randomNumber(int min,int max);
    Q_INVOKABLE void triggerSimulation(int vehicleCount,int delayMs);

signals:
    void deployVehicleSignal(QString lane,int direction);
};

#endif // TRAFFICCONTROLLER_H
/*
 * handling moving based on trafficcount logic:
 * search for vehicles.direction=45 or -45  for stop or move
\
