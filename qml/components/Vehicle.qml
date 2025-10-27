import QtQuick 2.15

Rectangle{

    id:vehicle

    property string type: "car"
    property color vehicleColor: "red"
    property real speed:0

    width: type === "truck" ?60:40
    height: type === "truck" ?30 :20
    radius: 5
    color: vehicleColor
    border.color: "black"
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: qsTr(Math.round(speed)+" km/h" )
        font.pixelSize: 8
        color: "white"
    }

    Behavior on x{
        NumberAnimation {duration:400} //easing.type: Easing.InOutQuad
    }

    Behavior on y{
        NumberAnimation {duration:400}
    }


}
