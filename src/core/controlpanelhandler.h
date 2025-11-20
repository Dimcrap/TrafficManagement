#ifndef CONTROLPANELHANDLER_H
#define CONTROLPANELHANDLER_H

#include <QObject>
#include <QDebug>

class ControlPanelHandler:public QObject
{
    Q_OBJECT

signals:
    void simulationCommand(bool command);
    void speedSlider(int s_value);
    void onTrafficState(QString state);

public:
   Q_INVOKABLE void setCommand(bool cmd) {qDebug()<<"set command called !"; emit simulationCommand(cmd);}
   Q_INVOKABLE void setSpeed(int value) {emit speedSlider(value);}
   Q_INVOKABLE void setTstatus(QString st){emit onTrafficState(st);}
};

#endif // CONTROLPANELHANDLER_H
