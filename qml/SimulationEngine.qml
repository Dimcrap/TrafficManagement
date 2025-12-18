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

    onTrafficStateChanged:{
        console.log("traffic state changed")
    }

    TrafficController{
        id:trafficCtrl;
    }

    function deployMachine(line,dir){
    var zpropery=defineZ(line,dir);

    var VehicleQml = `
        import QtQuick 2.15
        import  TrafficManagement 1.0
        Vehicle {
            line:"${line}"
            direction:${dir}
            moving:true
            speed:50
            width: 50
            height: 50
            trafficState:"${simengine.trafficState}"
            z:${zpropery}
        }
    `;

        var newVehicle = null;
           try {
               // 3. Ensure 'simengine' is a valid visual Item in scope.
               newVehicle = Qt.createQmlObject(VehicleQml, simengine, "dynamicVehicle_" + line);

               if (newVehicle) {
                  // console.log("Successfully created vehicle for line:", line);
               } else {
                   console.error("createQmlObject returned null for line:", line);
               }
           } catch (error) {
               // 4. This is the most important step for debugging!
               console.error("Error creating QML object for line " + line + ": " + error);
           }
        return newVehicle;
    }

    function deployVehicle(vehicleId,lane,dir){
        var vehicle =deployMachine(lane,dir);
        vehicles[vehicleId]=vehicle;
        vehiclesList.push(vehicle);
        return vehicles[vehicleId];
    }

    function setVehiclesSpeed(newSpeed){
        for(var i=0;i<vehiclesList.length;i++){
            vehiclesList[i].setSpeed(newSpeed);
        }

    }

    Connections{
        target:trafficCtrl

        function onDeployVehicleSignal(lane,direction){
            console.log("deploying  vehicle with id:"+simengine.vCount)
            deployVehicle(simengine.vCount,lane,direction)
            vCount++;
        }
    }

    function simulation(command){
        if(command==true){
            executing=true;
       // console.log("traffic status from simulation func:"+trafficState);
        if(simengine.trafficState=="High Traffic"){
            trafficCtrl.triggerSimulation(5,(600 / (runspeed/50)));
        }else if( simengine.trafficState=="Medium Traffic"){
            trafficCtrl.triggerSimulation(3,(500 / (runspeed/50)));
        }else {//( simengine.trafficState=="Low Traffic"){
            trafficCtrl.triggerSimulation(1,(500 / (runspeed/50)));
        }
        }else{
            executing=false;
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

    function changeMovment(currdirection){
        var Vlanecount=(trafficState=="Low Traffic")?2:(trafficState=="Medium Traffic")?3:5;
       //console.log("Vlanecount *2="+Vlanecount*2)
        var indexes=findV_indexs(Vlanecount*2,currdirection) //45
        var indexes2=findV_indexs(Vlanecount*2,-currdirection)  //-45
       /* for(var indx of indexes){
            console.log(indx);
        }*/

        if(currdirection==45){
            applyMovment(indexes,false);
            applyMovment(indexes2,true);
        }else{
            applyMovment(indexes,true);
            applyMovment(indexes2,false);
        }
    }

    function findV_indexs(vehiclesCount,dir){
        var list=[];
        let ex=0

        if(dir==45){
            for(var i=1;ex<=vehiclesCount/2;i+=4){
                list.push(i);
                ex++;
            }
            ex=0;
            for(var f=3;ex<=vehiclesCount/2;f+=4){
                list.push(f);
                ex++;
            }
            ex=0;
        }else{
            for(var c=2;ex<=vehiclesCount/2;c+=4){
                list.push(c);
                ex++;
            }
            ex=0;
            for(var k=4;ex<=vehiclesCount/2;k+=4){
                list.push(k);
                ex++;
            }

        }

        return list;
    }

    function applyMovment(idList,move){
        for(var i =0;i<=idList.length;i++){
           if(simengine.vehicles[idList[i]]){
               console.log("vehiclelist obj founed")
               simengine.vehicles[idList[i]].moving=move;
           }else{
                console.log("didn't find out the object");
           }
            /*if(simengine.vehicles[2]){
                console.log("vechicles[2] do exist");
            }else{
                console.log("vehicles[2] didn't exist");
            }*/
        }
    }

    function resetSim(){
        for(var i=vehiclesList.length-1;i>=0;i--){
            vehiclesList[i].destroy();
        }

        vehicles= [{}];
        vehiclesList= [];
        vCount=0;
        executing=false;
    }

    /*
    function tLight_handler(trafficlight1,trafficlight2){
        trafficlight1.
    }*/
}
