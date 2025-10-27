import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import TrafficManagement 1.0

Window {
    width: 760
    height: 480
    visible: true
    title: qsTr("Traffic Management")

    RowLayout{
        anchors.fill: parent
        spacing: 0

        Rectangle{
            id:simulationArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.75
            color:"#e8e8e8"

            Vehicle{
                x:100; y:100
                type:"car"
                vehicleColor:"gray"
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

            Text {
                anchors.centerIn: parent
                text: qsTr("simulation Area\n(Drag vehicles around!)")
                font.pixelSize: 20
                color:"grey"
                horizontalAlignment: Text.AlignHCenter
            }

        }

        ControlPanel{
            Layout.preferredWidth: parent.width *0.25
            Layout.fillHeight: true
        }
    }

}



















