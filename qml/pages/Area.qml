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
        poscalculator.calculateOrigin(width,height)
    }

    onWidthChanged:{
        poscalculator.calculateTileSize(width,height,10,10);
        poscalculator.calculateOrigin(width,height) ;
    }
    onHeightChanged:{
        poscalculator.calculateTileSize(width,height,10,10);
        poscalculator.calculateOrigin(width,height) ;
    }

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
                id:vehicleInstance
                vDirection :"vertical"
                vLine:"right"
                vwidth: poscalculator.tileWidth * 0.6
                vheight: poscalculator.tileHeight
                speed:75
                x:poscalculator.isoToScreen(Qt.point(5,6)).x
                y:poscalculator.isoToScreen(Qt.point(5,6)).y

                Component.onCompleted: {
                        console.log("=== Vehicle Debug ===")
                        console.log("tileWidth:", poscalculator.tileWidth)
                        console.log("tileHeight:", poscalculator.tileHeight)
                        console.log("Point result:", poscalculator.isoToScreen(Qt.point(5,10)))
                        console.log("Vehicle x:", x, "y:", y)
                        console.log("Vehicle width:", vwidth, "height:", vheight)
                    }
            }


            TrafficLight {
                x:250 ; y:70
                state:"green"
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
