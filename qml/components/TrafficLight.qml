import QtQuick 2.15
import QtQuick.Shapes

Item {
    id: container
    width: 46
    height: 84
    property string state: "red"



    Rectangle {
        id:trafficLight
        width: 45
        height: 80
        color:"#2a2a2a"
        radius: 10


        Rectangle{
            id:shodow
            anchors.centerIn: parent
            width: trafficLight.width+4
            height: trafficLight.height+4
            color:"#40000000"
            radius: parent.radius+2
            z:-1
        }

        Rectangle{
            id:shadow2
            anchors.centerIn: parent
            width: trafficLight.width+8
            height: trafficLight.width+8
            color: "#20000000"
            radius: trafficLight.radius+4
            z: -2
        }

       Shape{
           anchors.fill: parent

           ShapePath{
               startX:0;startY:0
               PathLine{x:trafficLight.width;y:0}
               PathLine{x:trafficLight.width;y:trafficLight.height}
               PathLine{x:0;y:trafficLight.height}
               PathLine{x:0;y:0}

               fillGradient:LinearGradient{
                   x1: 0;y1:0
                   x2:trafficLight.width; y2:trafficLight.height
                   GradientStop{ position:0.0; color:"#3a3a3a" }
                   GradientStop{ position:1.0; color:"#1a1a1a" }

               }
               strokeColor: "transparent"
           }
       }
    }


    Rectangle {
        anchors {fill:parent ;margins:3}
        color: "transparent"
        radius: parent.radius -2
        border{
            color:"#555"
            width: 1
        }

    }

    Column{
        spacing: 6
        anchors.centerIn: parent


        Rectangle{
            id:redLight
            width: 20;height: 20;radius: 20
            color: container.state === "red" ? "red" : "#400"
            border {color: "#200" ; width: 2}

            Rectangle{
                width: parent.width *0.3;height: parent.height * 0.3
                radius: width /2
                anchors {top: parent.top ; right: parent.right; margins: 5 }
                color: container.state === "red" ? "red" : "#400"
                opacity: 0.8

            }
        }

        Rectangle{
            id : yellowLight
            width: 20; height: 20; radius: 25;
            color:container.state==="yellow"? "yellow" : "#440"
            border {color : "#220"; width: 2}

            Rectangle{
            width: parent.width * 0.3 ; height: parent.height * 0.3
            radius: width/2
            anchors {top:parent.top;right:parent.right;margins: 5}
            color: container.state ==="yellow" ? "#ffffaa" :"#666622"
            opacity: 0.8
            }
        }

        Rectangle{
            id:greenLight
            width:20;height:20;radius:25;
            color:container.state ==="green" ? "green" : "#040"
            border {color: "#020";width:2}

            Rectangle{
                width:parent.width *0.3 ;height: parent.height * 0.3
                radius: width/2
                anchors {top:parent.top ; right: parent.right; margins: 5}
                color: container.state ==="green" ?"#aaffaa" : "#226622"
                opacity: 0.8
                }
        }


    }


}
