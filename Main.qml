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
           // property string trafficState: "Low Traffic"
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
                currCount:0
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
                          if(isExecuting){timecounter.startCounting()}
                          else{//console.log("executing was false in executionChanged");
                              timecounter.stopCounting();}
                      })
                      simEngine.runSChanged.connect(function(newSpeed){
                          timecounter.runspeed=newSpeed
                      })
                      simEngine.onTrafficStateChanged.connect(function(){
                          timecounter.trafficstage=simEngine.trafficState;
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
           simEngine.simulation(command);
        }
        function onSpeedSlider (value){
            simEngine.runspeed =value;
        }
        function onResetbtn (){
           simEngine.simulation(false)
            timecounter.resetCounter();
        }
        function onTrafficState(state){
            console.log("main qml caught signal:"+state)
            simEngine.trafficState=state;
        }
    }
        Connections{
            target:timecounter
            function onChangeTlights(color1,color2){
                    trafficlight1.state=color1;
                    trafficlight2.state=color2;
                   // console.log("changeTlights emmited");
                //simEngine.changeMovment(-45);
            }
           function onRoundfinsished(){
                simEngine.simulation(false)
                simEngine.resetSim();
                timecounter.stopCounting();
            }
        }


}











