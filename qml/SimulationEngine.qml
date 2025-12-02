import QtQuick 2.15
import Traffic.Ctrl

Item {

    id:simengine
    property bool executing:false
    property int areawidth: 500
    property int areaHeight: 480
    property int runspeed: 50
    property var vehicles: [{}]
    property var vehiclesList: []
    property int vCount: 1
    property string trafficState: "Low Traffic"



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
            vCount++;
        }
    }

    function simulation(command){
        if(command==true && simengine.trafficState=="Hight Traffic"){
            // timer.ms value handling requierd
            executing=true;
            trafficCtrl.triggerSimulation(5,(1000 / (runspeed/50)));

        }else if(command==true && simengine.trafficState=="Medium Traffic"){
            trafficCtrl.triggerSimulation(3,(1000 / (runspeed/50)));
            executing=true;

        }else if(command==true && simengine.trafficState=="Low Traffic"){
            trafficCtrl.triggerSimulation(1,(1000 / (runspeed/50)));
            executing=true;

        }

        executing=false;
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

    function resetSim(){
        vehicles= [{}];
        vehiclesList= [];
        executing=false;
    }

    function tLight_handler(trafficlight1,trafficlight2){

    }
}
