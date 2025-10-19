#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "controlpanelhandler.h"



int main(int argc, char *argv[])
{


    qmlRegisterType<ControlPanelHandler>("ControlPanelHandler",1,0,"ControlPanelHandler");


    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TrafficManagement", "Main");

    return app.exec();
}
