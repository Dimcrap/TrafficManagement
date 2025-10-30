import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import TrafficManagement 1.0

Item {

    id:root
    width: 759
    height: 479


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
                x:100; y:230
                source: "qrc:/images/greenbelt/tree1.png"
                width: parent.width * 0.08
                height: parent.height * 0.09
            }



            Image {
                id: house
                x:65; y:160
                source: "qrc:/images/structures/H4rightToLeft(1).png"
                width: parent.width * 0.08
                height:parent.height * 0.09


                onStatusChanged: {
                           if (status === Image.Error) {
                               console.log("Failed to load image:", source)
                           } else if (status === Image.Ready) {
                               console.log("Image loaded successfully")
                           }
                       }
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
