#ifndef CONTROLPANELHANDLER_H
#define CONTROLPANELHANDLER_H

#include <QObject>

class ControlPanelHandler:public QObject
{
    Q_OBJECT

public:


signals:
    void simulationCommand(bool command);
    void onSpeedSlider(int value);
    void onTrafficState(QString state);

};

#endif // CONTROLPANELHANDLER_H
