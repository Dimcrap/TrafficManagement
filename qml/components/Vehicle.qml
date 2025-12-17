import QtQuick 2.15
import MyApp.posCalculator
import Traffic.Ctrl

Item {
    id:root
    property bool moving: false
    property string line: "right"
    property int direction: 45
    property int speed: 50
    z:1
    property var parentwidth:parent.width
    property var parentheight:parent.height
    property double  currY: parent.width * 0.115;
    property double currX: parent.height *0.8475


    Positioncalculator{
        id:poscalculator
    }

    TrafficController{
        id:trafficCtrl
    }


    function findImage(Vline,Vdirection){
        var path=(Vdirection==-45)?"H":"V";
        let random =trafficCtrl.randomNumber(1,4);
        return "qrc:/images/isocars/"+path+Vline+random+".png";
    }


    function setSpeed(newspeed){
        speed=newspeed;
    }

    function findStartPos(lane,dir){
        var ParentPoint=Qt.point(parent.width,parent.height);
        if(lane=="right" && dir==45)
        {
            //console.log("parentP width at creation:"+parentwidth);
            return Qt.point((ParentPoint.x * 0.115), (ParentPoint.y *0.840));
        }if(dir==45 && lane=="left")
        {
            return Qt.point((ParentPoint.x * 0.749 ), (ParentPoint.y *0.173));
        }if(dir==-45 && lane=="right")
        {
            return Qt.point((ParentPoint.x * 0.82),(ParentPoint.y * 0.79))
        }else
        {
            return Qt.point((ParentPoint.x * 0.049),(ParentPoint.y * 0.191));
        }
    }

    function updateVehiclePos(){
        if(moving){
        x=currX;
        y=currY;
        }
       // console.log("updating position executed");
    }

    Image {
    id:car
    source: findImage(line,direction)
    anchors.fill: parent
    }

    Timer{
        id:movmentTimer
        interval: 35
        running :false
        repeat:true
        onTriggered: {

            var pos =movePos();

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

    function movePos(){
        var ParentPoint=Qt.point(parentwidth,parentheight);
        var angle;
        if(root.line=="right"&&root.direction==45){
            angle=poscalculator.calculateAngle(Qt.point(root.x,root.y),
                                                         Qt.point((ParentPoint.x * 0.81 ), (ParentPoint.y *0.22)));
            return poscalculator.moveToward(Qt.point(root.x,root.y),
                                            Qt.point((ParentPoint.x * 0.81 ), (ParentPoint.y *0.22)),
                                            root.speed/8);
        }else if(root.line=="left"&&root.direction==45){
            angle=poscalculator.calculateAngle(Qt.point(root.x,root.y),
                                                         Qt.point((ParentPoint.x * 0.068), (ParentPoint.y *0.775)));
            return poscalculator.moveToward(Qt.point(root.x,root.y),
                                            Qt.point((ParentPoint.x * 0.068), (ParentPoint.y *0.775)),
                                            root.speed/8);
        }else if(root.line=="right"&&root.direction==-45){
            angle=poscalculator.calculateAngle(Qt.point(root.x,root.y),
                                              Qt.point((ParentPoint.x * 0.099),(ParentPoint.y * 0.15)));
            return poscalculator.moveToward(Qt.point(root.x,root.y),
                                            Qt.point((ParentPoint.x * 0.099),(ParentPoint.y * 0.15)),
                                            root.speed/8);
        }else{
            angle=poscalculator.calculateAngle(Qt.point(root.x,root.y),
                                            Qt.point((ParentPoint.x * 0.775),(ParentPoint.y * 0.835)));
            return poscalculator.moveToward(Qt.point(root.x,root.y),
                                            Qt.point((ParentPoint.x * 0.775),(ParentPoint.y * 0.835)),
                                            root.speed/8);
        }


    }

    Component.onCompleted: {
        var pos =findStartPos(root.line,root.direction);
        currX=pos.x;
        currY=pos.y;
        updateVehiclePos();
        root.movement(true);
    }


}
