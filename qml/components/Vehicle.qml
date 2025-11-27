import QtQuick 2.15
import MyApp.posCalculator
import Traffic.Ctrl

Item {
    id:root
    property bool monving: false
    property string line: "right"
    property int direction: 45
    property int speed: 50
    z:1

    property double  currY
    property double currX


    Positioncalculator{
        id:poscalculator
    }

    TrafficController{
        id:trafficCtrl
    }


    function findImage(Vline,Vdirection){
        var path=(Vdirection==-45)?"H":"V";
        let random =trafficCtrl.randomNumber(1,4);
        return path+4;
    }


    function setSpeed(newspeed){
        speed=newspeed;
    }

    function findStartPos(lane,dir){
        var ParentPoint=Qt.point(parent.width,parent.height);
        if(lane=="right" && dir==45){
            return Qt.point((ParentPoint.x * 0.115), (ParentPoint.y *0.8475));
        }if(dir==45 && lane=="left"){
            return Qt.point((ParentPoint.x * 0.8 ), (ParentPoint.y *0.12));
        }if(dir==-45 && lane=="right"){
            return Qt.point((ParentPoint.x * 0.05),(ParentPoint.y * 0.20));
        }else{
            return Qt.point((ParentPoint.x * 0.87),(ParentPoint.y * 0.87))
        }
    }

    function updateVehiclePos(){
        if(moving){
        x=currX;
        y=currY;
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
            var pos =poscalculator.getnextMovement(currX,currY);
            if(pos.x==-1 || pos.y==-1){
                var restartPos=findStartPos(root.line,root.direction);
            }else{
                currX=pos.x;
                currY=pos.y;
            }
            updateVehiclePos();
        }
    }

    function movement(command){
        if(command==true){
            moving=true;
            movmentTimer.start();
        }else{
            moving=false;
            movmentTimer.stop();
        }
    }

    Component.onCompleted: {
        var pos =findStartPos(root.line,root.direction);
        currX=pos.x;
        currY=pos.y;
        updateVehiclePos();
    }


}
