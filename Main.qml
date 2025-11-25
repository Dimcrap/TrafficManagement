import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TrafficManagement 1.0
import MyApp.posCalculator

Window {

    id:mainwindow
    width: 760
    height: 480
    visible: true
    title: qsTr("Traffic Management")
    color: "#2c3e50"

    Positioncalculator{
        id :poscalculator
    }

    Component.onCompleted:{
        updateCalculation();
    }

    onWidthChanged:{
        updateCalculation();
    }

    onHeightChanged:{
        updateCalculation();
    }

    function updateCalculation(){
        poscalculator.calculateOrigin(mainwindow.width,mainwindow.height);
        poscalculator.calculateTileSize(mainwindow.width,mainwindow.height,10,10);
    }
    RowLayout{
        anchors.fill:  parent
        spacing:0

    Area{
        id:mainArea
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 4


        SimulationEngine{
            id:simEngine
            areawidth:mainArea.width
            areaHeight:mainArea.height

            Timecounter{
                id:timecounter
                runspeed:50
                trafficstage: "low"
                running: false
                currCount:0
                targetCount:60
                width: mainwindow.width * 0.09
                height: mainwindow.height *  0.12

                property point screenPos: Qt.point(0, 2)

                function updatePosition() {
                       screenPos = poscalculator.isoToScreen(Qt.point(0,0))
                       x = screenPos.x-mainwindow.width * 0.115
                       y = screenPos.y+mainwindow.height * 0.03
                   }

                  Component.onCompleted: {
                      screenPos = poscalculator.isoToScreen(Qt.point(0,0))
                      x = screenPos.x -mainwindow.width * 0.115
                      y = screenPos.y +mainwindow.height * 0.03
                  }

                  Connections {
                          target: mainwindow

                          function onWidthChanged() {
                             timecounter.updatePosition()
                            }
                          function onHeightChanged(){
                              timecounter.updatePosition()
                          }

                      }

            }
        }

    }

    ControlPanel{
        id: controlpanel
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 1
    }

    }
    Connections{
        target:controlPanelHandler
        onSimulationCommand:function (command){
            console.log("simulation state:"+command)
            timecounter.running=command;
        }
        onSpeedSlider:function (value){
            timecounter.runspeed=value;
        }

        //onSpeedSlider(int value);
        //onTrafficState(QString state);
    }

}



















