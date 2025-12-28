#include "trafficcontroller.h"
#include  <QRandomGenerator>


trafficcontroller::trafficcontroller(QObject * parent):QObject(parent){
    m_timer =new QTimer(this);
    connect(m_timer,&QTimer::timeout,this,[this]{
        if(!m_remainvehicles<=0){
        emit deployVehicleSignal("right",45);
        emit deployVehicleSignal("right",-45);
        emit deployVehicleSignal("left",45);
        emit deployVehicleSignal("left",-45);
        }
        m_remainvehicles --;
        if(m_remainvehicles<0){
            m_timer->stop();
        }

    });
}

int trafficcontroller::randomNumber(int min, int max)
{
    return QRandomGenerator::global()->bounded(min,max+1);
}

void trafficcontroller::triggerSimulation(int vehicleCount, int delayMs)
{
    m_remainvehicles=vehicleCount;

    emit deployVehicleSignal("right",45);
    emit deployVehicleSignal("right",-45);
    emit deployVehicleSignal("left",45);
    emit deployVehicleSignal("left",-45);

    m_remainvehicles --;

    m_timer->start(delayMs);
}
