#ifndef CONTROLPANELHANDLER_H
#define CONTROLPANELHANDLER_H

#include <QObject>

class ControlPanelHandler:public QObject
{
    Q_OBJECT

public:
    ControlPanelHandler();
    simulationCommand(bool command);
    onSpeedSlider(int value);
    onTrafficState(QString state);

};

#endif // CONTROLPANELHANDLER_H
