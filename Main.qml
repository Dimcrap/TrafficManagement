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
        anchors.fill:  parent
        spacing:0

    Area{
        id:mainArea
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 4
    }

    ControlPanel{
        id: controlpanel
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
    }

    }

}



















