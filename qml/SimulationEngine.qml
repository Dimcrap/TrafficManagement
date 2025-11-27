import QtQuick 2.15

Item {

    id:simengine
    property bool executing:false
    property int areawidth: 500
    property int areaHeight: 480
    property  var vehicles: [{}]
    property var vehiclesList: []


    signal executionChanged(bool isExecuting)

    onExecutingChanged: {
        executionChanged(executing)
    }

    function deployMachine(line,dir){

    var VehicleQml = `
        import QtQuick 2.15
        Vehicle {
            line:"${line}"
            direction:"${line}"
            speed:50
            width: 50
            height: 50
        }
    `;
        vehicleQml=Qt.createQmlObject(vehicleQml,simengine,"dynamicImage");
        return vehicleImage
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

    function Simulation(command,trafficState,speed){
        var Tstate=(trafficState=="High Traffic")?5:(trafficState=="Medium Traffic")?3:1;
        if(command==true){
            for (var i=0; i < Tstate ; i++ ){
                deployVehicle(right,45);
                //delay after each creation
                //configure z
            }
            for (var i=0; i < Tstate ; i++ ){
                deployVehicle(right,45);
            }
            for (var i=0; i < Tstate ; i++ ){
                deployVehicle(right,45);
            }
            for (var i=0; i < Tstate ; i++ ){
                deployVehicle(right,45);
            }

        }
    }

}
