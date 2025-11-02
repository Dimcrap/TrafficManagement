import QtQuick 2.15


Item {

    id:vehicle


    property string vDirection:"vertical"
    property string vLine:"right"
    property int vwidth:24
    property int vheight:24
    property real speed:1.7

/*
    Component.onCompleted: {
         console.log("Vehicle properties:", vDirection, vLine, vwidth, vheight, speed)
     }*/


    function selectCar(direction,line){
        var randomNum= Math.floor(Math.random() *4 )+1

        if(direction==="vertical" && line==="right"){
            return "qrc:/images/isocars/Vright"+randomNum+".png"
        }else if(direction==="vertical" && line==="left"){
            return "qrc:/images/isocars/Vleft"+randomNum+".png"
        }else if(direction==="horizental" && line==="right"){
            return "qrc:/images/isocars/Vright"+randomNum+".png"
        }else{//direction==horizentical && line==left
            return "qrc:/images/isocars/Vleft"+randomNum+".png"
        }


    }

    width: vwidth
    height: vheight

    Image {
        id:carImg
        source: selectCar(vDirection,vLine)
        anchors.fill: parent
    }

/*
    Text {
        anchors.centerIn: parent
        text: qsTr(Math.round(speed)+" km/h" )
        font.pixelSize: 8
        color: "black"
    }
    Behavior on x{
        NumberAnimation {duration:400} //easing.type: Easing.InOutQuad
    }

    Behavior on y{
        NumberAnimation {duration:400}
    }
*/


}
