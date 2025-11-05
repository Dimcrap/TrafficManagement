import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import TrafficManagement 1.0
import MyApp.posCalculator

Item {

    id:root

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
        poscalculator.calculateOrigin(root.width,root.height)
        poscalculator.calculateTileSize(root.width,root.height,10,10);
    }

    RowLayout{
        anchors.fill: parent
        spacing: 0


        Rectangle{
            id:simulationArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            gradient: Gradient {
                        GradientStop { position: 0.0; color: "#ffff99" }
                        GradientStop { position: 1.0; color: "#999900" }
                    }

            TrafficLight {
                id:trafficlight1
                state:"red"
                width: root.width * 0.07
                height: root.height * 0.20

                property point screenPos: Qt.point(0, 2)

                function updatePosition() {
                       screenPos = poscalculator.isoToScreen(Qt.point(0,2))
                       x = screenPos.x-root.width * 0.05
                       y = screenPos.y+root.height * 0.03
                   }

                  Component.onCompleted: {
                      screenPos = poscalculator.isoToScreen(Qt.point(0,2))
                      x = screenPos.x -root.width * 0.05
                      y = screenPos.y +root.height * 0.03
                      console.log("Initial position - x:", x, "y:", y)
                  }

                  Connections {
                          target: root

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
                state:"red"
                width: root.width * 0.07
                height: root.height * 0.20


                property point screenPos: Qt.point(2, 0)

                function updatePosition() {
                       screenPos = poscalculator.isoToScreen(Qt.point(2,0))
                       x = screenPos.x+root.width * 0.04
                       y = screenPos.y +root.height * 0.03
                   }

                  Component.onCompleted: {
                      screenPos = poscalculator.isoToScreen(Qt.point(2,0))
                      x = screenPos.x +root.width * 0.04
                      y = screenPos.y +root.height * 0.03
                      console.log("Initial position - x:", x, "y:", y)
                  }

                  Connections {
                          target: root

                          function onWidthChanged() {
                             trafficlight2.updatePosition()
                            }
                          function onHeightChanged(){
                              trafficlight2.updatePosition()
                          }

                      }

            }

            Image {
                id: arrow1
                source: "qrc:/images/twoarrow.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(0,5));
                    }

                x:screenPos.x//-(root.width * 0.15)
                y:screenPos.y-(root.height * 0.02)

                width: root.width * 0.07
                height:root.height * 0.1
                rotation: -55
            }

            Image {
                id: arrow2
                source: "qrc:/images/twoarrow.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(5,0));
                    }

                x:screenPos.x-(root.width * 0.01)
                y:screenPos.y -(root.height * 0.02)

                width: root.width * 0.07
                height:root.height * 0.1
                rotation: 55
            }
            Image {
                id: mainroad
                source: "qrc:/images/structures/mainroad.png"


                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(0,10));
                    }

                x:screenPos.x-(root.width * 0.15)//poscalculator.isoToScreen(Qt.point(5,5)).x
                y:screenPos.y-(root.height * 0.43)//poscalculator.isoToScreen(Qt.point(5,5)).y

                width: root.width+(root.width * 0.30)
                height: root.height+(root.height * 0.55)


            }

            Image {
                id: house1
                source: "qrc:/images/structures/H4rightToLeft(1).png"

                rotation: -1
                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(1,10));
                    }

                x:screenPos.x - root.width * 0.03
                y:screenPos.y + (root.height * 0.34)


                width: poscalculator.tileWidth * 0.4+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight
            }

            Image {
                id: house2
                source: "qrc:/images/structures/New Project.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(1,10));
                    }

                x:screenPos.x - root.width * 0.05
                y:screenPos.y + (root.height * 0.17)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight
            }



            Image {
                id: house3
                source: "qrc:/images/structures/H3leftToright.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(1,6));
                    }

                x:screenPos.x - root.width * 0.05
                y:screenPos.y + (root.height * 0.25)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }

            Image {
                id: house4
                source: "qrc:/images/structures/HleftToright.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(1,8));
                    }

                x:screenPos.x - root.width * 0.05
                y:screenPos.y + (root.height * 0.25)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }

            Image {
                id: house5
                source: "qrc:/images/structures/H4rightToLeft(1).png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(3,8));
                    }

                x:screenPos.x - root.width * 0.05
                y:screenPos.y + (root.height * 0.22)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }

            Image {
                id: house6
                source: "qrc:/images/structures/H2rightToleft.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(0,9));
                    }

                x:screenPos.x //- root.width * 0.1
                y:screenPos.y + (root.height * 0.12)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }


            Image {
                id:tree1
                source: "qrc:/images/greenbelt/tree5.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(8,9));
                    }

                x:screenPos.x + root.width * 0.02
                y:screenPos.y + (root.height * 0.14)+poscalculator.tileHeight *0.6//+ root.width * 0.01

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight
            }

            Image {
                id: tower
                source: "qrc:/images/structures/Tower.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(12,12));
                    }

                x:screenPos.x - root.width * 0.02
                y:screenPos.y + (root.height * 0.03)

                width:  poscalculator.tileWidth //+ poscalculator.tileWidth * 0.1
                height: poscalculator.tileHeight *2 + poscalculator.tileHeight * 0.5
            }

            Image {
                id: grass3
                source: "qrc:/images/greenbelt/grass.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(14,12));
                    }

                x:screenPos.x //- root.width * 0.05
                y:screenPos.y //+ (root.height * 0.17)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }


            Image {
                id: grass4
                source: "qrc:/images/greenbelt/grass.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(12,15));
                    }

                x:screenPos.x //- root.width * 0.05
                y:screenPos.y //+ (root.height * 0.17)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight

            }


            Image {
                id: grass
                source: "qrc:/images/greenbelt/grass2.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(13,15));
                    }

                x:screenPos.x + root.width * 0.02
                y:screenPos.y //+ (root.height * 0.17)

                width:  poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight * 0.5

            }


            Image {
                id: grass2
                source: "qrc:/images/greenbelt/grass2.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(15,13));
                    }

                x:screenPos.x - root.width * 0.03
                y:screenPos.y //+ (root.height * 0.17)

                width:  poscalculator.tileWidth
                height: poscalculator.tileHeight+ poscalculator.tileHeight * 0.5
            }

            Image {
                id: tree2
                source: "qrc:/images/greenbelt/tree3.png"

                property point screenPos: {

                        var _ = poscalculator.tileWidth;
                        var __ = poscalculator.origin;
                        return poscalculator.isoToScreen(Qt.point(14,14));
                    }

                x:screenPos.x - root.width * 0.02
                y:screenPos.y //+ (root.height * 0.17)

                width: poscalculator.tileWidth * 0.1+ poscalculator.tileWidth
                height: poscalculator.tileHeight *2 + poscalculator.tileHeight * 0.09

            }


/*
            Vehicle{
                id:vehicleInstance
                vDirection :"vertical"
                vLine:"right"
                vwidth: poscalculator.tileWidth * 0.6
                vheight: poscalculator.tileHeight
                speed:75

               // x:poscalculator.isoToScreen(Qt.point(5,6)).x
                //y:poscalculator.isoToScreen(Qt.point(5,6)).y

                Component.onCompleted: {
                    x=poscalculator.isoToScreen(Qt.point(5,6)).x
                    y=poscalculator.isoToScreen(Qt.point(5,6)).y
                        console.log("=== Vehicle Debug ===")
                        console.log("tileWidth:", poscalculator.tileWidth)
                        console.log("tileHeight:", poscalculator.tileHeight)
                        console.log("Point result:", poscalculator.isoToScreen(Qt.point(5,6)))
                        console.log("Vehicle x:", x, "y:", y)
                        console.log("Vehicle width:", vwidth, "height:", vheight)
                    }
            }

*/

           /* Text {
                anchors.centerIn: parent
                text: qsTr("simulation Area\n(Drag vehicles around!)")
                font.pixelSize: 20
                color:"grey"
                horizontalAlignment: Text.AlignHCenter
            }*/

        }

    }

}
