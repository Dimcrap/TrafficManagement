import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {

    id: controlPanel
    color: "#f5f5f5"
    border.color: "#cccccc"

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
                //console.log("Simulation started!")
                controlPanelHandler.setCommand(true);
            }
        }

        Button{
            text:"Stop Simulation"
            Layout.fillWidth: true
            onClicked:{
                controlPanelHandler.setCommand(false);
            }
        }

        Button{
            text:"Reset"
            Layout.fillWidth: true
            onClicked:{
                console.log("Reset button clicked")
                controlPanelHandler.resetEmiter();
            }
        }

        Slider{
            id:speedSlider
            Layout.fillWidth:true
            from: 0
            to:100
            value: 50
            onValueChanged: controlPanelHandler.setSpeed(value)
                //console.log("Speed set to :",value)
        }

        Text {
            text: qsTr("Simulation Speed: "+Math.round(speedSlider.value))
            Layout.alignment: Qt.AlignHCenter
        }

        ComboBox{
            Layout.fillWidth: true
            model: ["Low Traffic","Medium Traffic","High Traffic"]
            //onCurrentTextChanged:handler.onTrafficState(currentText)
            onCurrentTextChanged: controlPanelHandler.setTstatus(currentText)
                //console.log("Traffic density:",currentText)
        }

    }
}
