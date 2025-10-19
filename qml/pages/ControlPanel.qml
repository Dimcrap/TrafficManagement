import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import ControlPanelHandler


Rectangle {

    id: controlPanel
    color: "#f5f5f5"
    border.color: "#cccccc"

    ControlPanelHandler{
        id:handler
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10

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
                console.log("Simulation started!")
            }
        }

        Button{
            text:"Stop Simulation"
            Layout.fillWidth: true
            onClicked: console.log("Simulation stoped!")
        }

        Slider{
            id:speedSlider
            Layout.fillWidth:true
            from: 0
            to:100
            value: 50
            //onValueChanged: handler.onSpeedSlider(value)
            onValueChanged: console.log("Speed set to :",value)
        }

        Text {

            text: qsTr("Simulation Speed: "+Math.round(speedSlider.value))
            Layout.alignment: Qt.AlignHCenter
        }

        ComboBox{
            Layout.fillWidth: true
            model: ["Low Traffic","Medium Traffic","High Traffic"]
            //onCurrentTextChanged:handler.onTrafficState(currentText)
            onCurrentTextChanged: console.log("Traffic density:",currentText)

        }

    }
}
