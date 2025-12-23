import QtQuick 2.15
import MyApp.posCalculator
import Traffic.Ctrl

Item {
    id:root
    property bool moving: false
    property string line: "right"
    property int direction: 45
    property int speed: 30
    property int  vID: 0
    property var parentwidth:parent.width
    property var parentheight:parent.height
    property double  currY: parent.width * 0.115;
    property double currX: parent.height *0.8475
    property string trafficState:"Low Traffic"
    property var  endPos
    property var startPos
    property var stoppoint
    property bool stopProcess:false
    property double stopRow
    signal vehicleReached(int vehicleId)

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
            return Qt.point((ParentPoint.x * 0.115), (ParentPoint.y *0.840));
        }if(dir==45 && lane=="left")
        {
            return Qt.point((ParentPoint.x * 0.749 ), (ParentPoint.y *0.173));
        }if(dir==-45 && lane=="right")
        {
            return Qt.point((ParentPoint.x * 0.82),(ParentPoint.y * 0.79));
        }else
        {
            return Qt.point((ParentPoint.x * 0.049),(ParentPoint.y * 0.191));
        }
    }

    function findEndPos(){
        var ParentPoint=Qt.point(parentwidth,parentheight);
        if(root.line=="right"&&root.direction==45)
        {
            return Qt.point((ParentPoint.x * 0.81 ), (ParentPoint.y *0.22));
        }else if(root.line=="left"&&root.direction==45)
        {
            return Qt.point((ParentPoint.x * 0.068), (ParentPoint.y *0.775));

        }else if(root.line=="right"&&root.direction==-45)
        {
            return Qt.point((ParentPoint.x * 0.099),(ParentPoint.y * 0.15));
        }else{
            return Qt.point((ParentPoint.x * 0.775),(ParentPoint.y * 0.835));
        }
    }

    function updateVehiclePos(){
        if(moving){
            //console.log("update position exectuions"+Qt.point(currX,currY));
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
        interval: 35
        running :false
        repeat:true
        onTriggered: {

            //console.log("before movePos finding :"+Qt.point(currX,currY));
            var pos =movePos();
           // console.log("stopPos:"+stoppoint);
           //console.log("nextmove pos:"+pos);
            if(stoppoint.x<pos.x){movmentTimer.running=false}else
            /*if(root.stopProcess){
                applyStop()
            }else{
             movmentTimer.running=true*/

            if(pos.x==-1 || pos.y==-1){
                var restartPos=findStartPos(root.line,root.direction);
            }else{
                currX=pos.x;
                currY=pos.y;
            }

            //}

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
        var vehiclespeed=(trafficState=="Low Traffic")?root.speed/13:(trafficState=="Medium Traffic")?
                                                            root.speed/15:root.speed/19;
        var nextPos=poscalculator.moveToward(Qt.point(root.x,root.y),endPos,vehiclespeed);
        /*if(stopProcess){
            applyStop(true);
        }else{
            applyStop(false)
        }*/
        if(nextPos==endPos){
            vehicleReached(vID);
            return nextPos;
        }else{
            return nextPos;
        }

    }

    function applyStop(xpos){
        if((root.direction==45&&root.line=="right")||(root.direction==-45)&&(root.line=="left")){
        if(xpos>stoppoint.x){
            movmentTimer=false;
        }

        }else{
        if(xpos>stoppoint.x){
            movmentTimer=false;
        }

        }

    }

    Component.onCompleted: {
        var pos =findStartPos(root.line,root.direction);
        endPos  =findEndPos();
        startPos=pos//findStartPos(root.line,root.direction)
       // stoppoint=  poscalculator.stopPoint(startPos,endPos,root.stopRow);
        stoppoint=poscalculator.stopPoint(startPos,endPos,root.stopRow)
        console.log("start points for StopPos:"+startPos+"stop point:"+stoppoint);//root.startPos,root.startPos));
        currX=pos.x;
        currY=pos.y;
        //console.log("object start pos:"+Qt.point(currX,currY));
        updateVehiclePos();
        root.movement(true);
    }


}
