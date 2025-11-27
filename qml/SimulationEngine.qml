import QtQuick 2.15
import Traffic.Ctrl

Item {

    id:simengine
    property bool executing:false
    property int areawidth: 500
    property int areaHeight: 480
    property int runspeed: 50
    property  var vehicles: [{}]
    property var vehiclesList: []
    property int vCount: 1

    signal executionChanged(bool isExecuting)
    signal runSChanged(int newSpeed)

    onExecutingChanged: {
        executionChanged(executing)
    }

    onRunspeedChanged: {
        runSChanged(runspeed)
    }

    TrafficController{
        id:trafficCtrl;
    }

    function deployMachine(line,dir){
    var zpropery=defineZ(line,dir);

    var VehicleQml = `
        import QtQuick 2.15
        Vehicle {
            line:"${line}"
            direction:"${line}"
            speed:50
            width: 50
            height: 50
            z:"${zpropery}"
        }
    `;
        vehicleQml=Qt.createQmlObject(vehicleQml,simengine,"dynamicImage");
        return VehicleQml
    }

    function deployVehicle(vehicleId,lane,dir){
        var vehicle =deployMachine(lane,dir);
        vehicles[vehicleId]=vehicle;
        vehiclesList.push(vehicle);
        return vehicle;
    }

    function setVehiclesSpeed(newSpeed){
        for(var i=0;i<vehiclesList.length;i++){
            vehiclesList[i].setSpeed(newSpeed);
        }

    }

    Connections{
        target:TrafficController

        function deployVehicleSignal(lane,direction){
            deployVehicle(simengine.vCount,lane,direction)
        }
    }

    function simulation(command,trafficState,speed){
        var Tstate=(trafficState=="High Traffic")?5:(trafficState=="Medium Traffic")?3:1;
        if(command==true && trafficState=="Hight Traffic"){
            // timer.ms value handling requierd
            trafficCtrl.triggerSimulation(5,3000);
        }else if(command==true && trafficState=="Medium Traffic"){
            trafficCtrl.triggerSimulation(3,3000);
        }else{
            trafficCtrl.triggerSimulation(1,3000);
        }
    }

    function defineZ(lane,direction){
        if(lane=="right"&&direction==45){
            return 1
        }else if(lane=="left"&&direction==45){
            return 2
        }else if(lane=="right"&&direction==-45){
            return 3
        }else{
            return 4
        }
    }
}
