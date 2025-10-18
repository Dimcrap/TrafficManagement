import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: controlPanel
    color: "#dee46f "
    border.color: "bebebe"

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
                conslog.log("Simulation started!")
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
            onValueChanged: console.log("Speed set to :",value)
        }

        Text {

            text: qsTr("Simulation Speed: "+Math.round(speedSlider.value))
            Layout.alignment: Qt.AlignHCenter
        }

        ComboBox{
            Layout.fillWidth: true
            model: ["Low Traffic","Medium Traffic","High Traffic"]
            onCurrentTextChanged: console.log("Traffic density:",currentText)
        }

        RowLayout{
            Layout.fillWidth: true

            Button{
                text:"Add Car"
                Layout.fillWidth: true
                onClicked: console.log("Add car clicked")
            }

            Button{
                text:"Add Truck"
                Layout.fillWidth: true
                onClicked: console.log("Add truck clicked")
            }
        }
    }
}
