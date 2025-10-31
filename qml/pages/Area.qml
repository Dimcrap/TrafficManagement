import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import TrafficManagement 1.0
import MyApp.posCalculator

Item {

    id:root
    width: parent.width
    height: parent.width

    Positioncalculator{
        id :poscalculator
    }

    Component.onCompleted:{
        poscalculator.calculateTileSize(width,height,10,10)
    }

    onWidthChanged:poscalculator.calculateTileSize(width,height,10,10)
    onHeightChanged:poscalculator.calculateTileSize(width,height,10,10)

    RowLayout{
        anchors.fill: parent
        spacing: 0


        Rectangle{
            id:simulationArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.75
            color:"#e8e8e8"


            Image {
                id: tree
                source: "qrc:/images/greenbelt/tree1.png"
                width: poscalculator.tileWidth * 0.6
                height: poscalculator.tileHeight

                x:poscalculator.isoToScreen(Qt.point(3,2)).x
                y:poscalculator.isoToScreen(Qt.point(3,2)).y
            }



            Image {
                id: house
                source: "qrc:/images/structures/H4rightToLeft(1).png"
                width: poscalculator.tileWidth * 0.6
                height: poscalculator.tileHeight

                x:poscalculator.isoToScreen(Qt.point(4,1)).x
                y:poscalculator.isoToScreen(Qt.point(4,1)).y

/*
                onStatusChanged: {
                           if (status === Image.Error) {
                               console.log("Failed to load image:", source)
                           } else if (status === Image.Ready) {
                               console.log("Image loaded successfully")
                           }
                       }*/
            }

            Image {
                id: house2
                source: "qrc:/images/structures/H3leftToright.png"
                width: poscalculator.tileWidth * 0.6
                height: poscalculator.tileHeight

                x:poscalculator.isoToScreen(Qt.point(5,2)).x
                y:poscalculator.isoToScreen(Qt.point(5,2)).y
            }

            Vehicle{
                x:50; y:50
                type:"car"
                vehicleColor:"yellow"
                speed:60

            }
            Vehicle{
                x:150 ; y:150
                type:"truck"
                vehicleColor: "blue"
                speed:40
            }
            Vehicle{
                x:100;y:100
                type:"car"
                vehicleColor: "red"
                speed:70
            }

            TrafficLight {
                x:250 ; y:70
                state:"red"
            }

           /* Text {
                anchors.centerIn: parent
                text: qsTr("simulation Area\n(Drag vehicles around!)")
                font.pixelSize: 20
                color:"grey"
                horizontalAlignment: Text.AlignHCenter
            }*/

        }

        ControlPanel{
            Layout.preferredWidth: parent.width *0.20
            Layout.fillHeight: true
        }
    }

}
