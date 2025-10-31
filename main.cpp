#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "controlpanelhandler.h"
#include "positioncalculator.h"
#include <QDebug>
#include <QResource>
#include <QDir>


int main(int argc, char *argv[])
{



    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<ControlPanelHandler>("ControlPanelHandler",1,0,"ControlPanelHandler");
    qmlRegisterType<PositionCalculator>("MyApp.posCalculator",1,0,"Positioncalculator");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    PositionCalculator positioncalculator;



  engine.loadFromModule("TrafficManagement", "Main");



  QResource resource(":/images/greenbelt/tree1.png");
  if (resource.isValid()) {
      qDebug() << "Resource found! Size:" << resource.size();
  } else {
      qDebug() << "Resource NOT found!";

      // List all available resources
      qDebug() << "Available resources:";
      QStringList allResources = {":/", ":/images", ":/images/greenbelt"};
      for (const QString &path : allResources) {
          if (QDir(path).exists()) {
              qDebug() << "Directory exists:" << path;
              QStringList entries = QDir(path).entryList();
              for (const QString &entry : entries) {
                  qDebug() << "  -" << entry;
              }
          }
      }
  }


    return app.exec();
}
