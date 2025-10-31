import QtQuick 2.15

// Force QML module regeneration
Item {

    id:vehicle

    property int model: 1
    property color vehicleColor: "red"
    property real speed:0

    function selectCar(direction,line){
        var randomNum= Math.floor(Math.random() *4 )+1
        if(direction==vertical && line==right){

        }else if(direction==vertical && line==right){
            return "qrc:/images/isocars/Vright"+randumNum+".png"
        }else if(direction==vertical && line==left){
            return "qrc:/images/isocars/Vleft"+randumNum+".png"
        }else if(direction==horizentical && line==right){
            return "qrc:/images/isocars/Vright"+randumNum+".png"
        }else{//direction==vertical && line==left
            return "qrc:/images/isocars/Vleft"+randumNum+".png"
        }


    }


    Image {
        id:carimg
        source: model== 1 ? "qrc:/images/isocars/"
    }
    width: type === "truck" ?60:40
    height: type === "truck" ?30 :20

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
