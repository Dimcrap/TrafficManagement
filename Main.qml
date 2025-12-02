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
            executing:false
            anchors.fill: mainArea
            runspeed: 50
            //areawidth:mainArea.width
            //areaHeight:mainArea.height
            property string trafficState: "Low Traffic"
            property int simRunningSpeed: 1000

            TrafficLight {
                id:trafficlight1
                state:"yellow"
                width: mainwindow.width * 0.05
                height: mainwindow.height * 0.19

                property point screenPos: Qt.point(0, 2)

                function updatePosition() {
                       screenPos = poscalculator.isoToScreen(Qt.point(0,2))
                       x = screenPos.x-mainwindow.width * 0.09
                       y = screenPos.y+mainwindow.height * 0.025
                   }

                  Component.onCompleted: {
                      screenPos = poscalculator.isoToScreen(Qt.point(0,2))
                      x = screenPos.x -mainwindow.width * 0.09
                      y = screenPos.y +mainwindow.height * 0.025
                     // console.log("Initial position - x:", x, "y:", y)

                  }

                  Connections {
                          target: mainwindow

                          function onWidthChanged() {
                             trafficlight1.updatePosition()
                            }
                          function onHeightChanged(){
                              trafficlight1.updatePosition()
                          }

                      }

            }

            TrafficLight {
                id:trafficlight2
                state:"yellow"
                width: mainwindow.width * 0.05
                height: mainwindow.height * 0.19

                property point screenPos: Qt.point(2, 0)

                function updatePosition() {
                       screenPos = poscalculator.isoToScreen(Qt.point(2,0))
                       x = screenPos.x-mainwindow.width * 0.09
                       y = screenPos.y+mainwindow.height * 0.025
                   }

                  Component.onCompleted: {
                      screenPos = poscalculator.isoToScreen(Qt.point(2,0))
                      x = screenPos.x -mainwindow.width * 0.09
                      y = screenPos.y +mainwindow.height * 0.025
                     // console.log("Initial position - x:", x, "y:", y)
                  }

                  Connections {
                          target: mainwindow

                          function onWidthChanged() {
                             trafficlight2.updatePosition()
                            }
                          function onHeightChanged(){
                              trafficlight2.updatePosition()
                          }

                      }

            }

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
                      simEngine.executionChanged.connect(function(isExecuting){
                          timecounter.running=isExecuting
                      })
                      simEngine.runSChanged.connect(function(newSpeed){
                          timecounter.runspeed=newSpeed
                      })
                      simEngine.onTrafficStateChanged.connect(function(state){
                          timecounter.trafficstage=state;
                      })

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
        function onSimulationCommand (command){
            simEngine.executing = command;
           //simEngine.simulation(command)
        }
        function onSpeedSlider (value){
            simEngine.runspeed =value;
        }
        function onResetbtn (){
           simEngine.executing = false;
            //simEngine.resetSim();
            timecounter.resetCounter();
        }
        function onTrafficState(state){
            simEngine.trafficState=state;
        }

    /*Connections{
    target: simEngine
    onExe

    }*/
        //onSpeedSlider(int value);
        //onTrafficState(QString state);
    }

}



















