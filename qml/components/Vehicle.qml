import QtQuick 2.15
import MyApp.posCalculator
import Traffic.Ctrl

Item {
    id:root
    property bool monving: true
    property string line: "right"
    property int direction: 45
    property int speed: 50

    var currY,currX;
    var ImagePath;

    Positioncalculator{
        id:poscalculator
    }

    TrafficController{
        id:trafficCtrl
    }

    function findImage(Vline,Vdirection){
        var path=(Vdirection==-45)?"H":"V";
        let random =trafficCtrl.randomNumber(1,4);//Math.floor(Math.random()*( 4-1 + 1)+1);
        return path+4;
    }


    function setSpeed(newspeed){
        speed=newspeed;
    }

    function findStartPos(lane,dir){
        var ParentPoint=Qt.point(parent.width,parent.height);

        if(lane=="right" && dir==45){
            return Qt.point((parentPoint.x -parent.width * 0.085 ), (ParentPoint.y - parent.height 0.9));

        }if(dir==45 && lane=="left"){

        }if(dir==-45 && lane=="right"){

        }else{

        }
    }

    function updateVehiclePos(){
        if(moving){
        //var pos = poscalculator.getnextPosition(currX,currY);
        x=pos.X;
        y=pos.Y;
        }
    }

    Image {
    id:car
    source: findImage(line,direction)
    anchors.fill: parent
    }

    Timer{
        id:movmentTimer
        interval: 13
        running :false
        repeat:true
        onTriggered: {

        }
    }

    function move(){

    }

    Component.onCompleted: updateVehiclePos()
}
