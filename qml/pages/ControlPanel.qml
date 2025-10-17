import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: controlPanel
    color: "#dee46f "
    border.color: "bebebe"

    ColumnLayout{
        //a
        //
        spacing: 10

        Text {
            text: qsTr("Traffic Control")
            font.bold: true
            font.pixelSize: 16
            Layout.alignment: Qt.AlignHCenter
        }

        Button{
            text: "Start Simulatin"
            Layout.fillWidth: true
            onClicked: {
                conslog.log("Simulation started!")
            }
        }

        Button{
            text:"Stop Simulation"
            Layout.fillWidth: true
            onClicked: console.log("Simulation stoped!")
        }

    }
}
