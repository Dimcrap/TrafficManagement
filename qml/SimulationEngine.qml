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
    property bool deployed:false
    property var primaryZlist:primaryZfinder();
    property var definedV_zs:new Map([["right45",primaryZlist[0]],["left45",primaryZlist[1]],
                               ["right-45",primaryZlist[2]],["left-45",primaryZlist[3]]])
    property var laneCapacity:new Map([["right45",5],["left45",5],["right-45",5],["left-45",5]])
    property int countlimit:(trafficState=="Low Traffic")?8:(trafficState=="Medium Traffic")?12:20;

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
        primaryZlist=primaryZfinder();
        definedV_zs:([["right45",primaryZlist[0]],["left45",primaryZlist[1]],
                                      ["right-45",primaryZlist[2]],["left-45",3]]);
        countlimit=(trafficState=="Low Traffic")?8:(trafficState=="Medium Traffic")?12:20;
    }

    onDeployedChanged: {
       // console.log("stopping handler is executing");
        v_stopHandler("red");
    }

    TrafficController{
        id:trafficCtrl;
    }

    function deployMachine(line,dir,id){
    var zpropery=defineZ(line,dir);
    /*    if(line=="left"){
        console.log("deploying dir:"+dir+" with  z:"+zpropery);
        }*/
    var stopingrow=defineStopRow(id,dir,line);
    //console.log("vehicle created by stopping id:"+stopingrow)
    var VehicleQml = `
        import QtQuick 2.15
        import  TrafficManagement 1.0
        Vehicle {
            line:"${line}"
            direction:${dir}
            vID:${id}
            moving:true
            speed:50
            width: 50
            height: 50
            trafficState:"${simengine.trafficState}"
            z:${zpropery}
            stopRow:${stopingrow}
        }
    `;


        var newVehicle = null;
           try {
               newVehicle = Qt.createQmlObject(VehicleQml, simengine, "dynamicVehicle_" + line);

               if (newVehicle) {
                  // console.log("Successfully created vehicle for line:", line);
                   /*for (var v of vehiclesList){
                       console.log("vehiclelits obj:"+v)
                   }*/
               } else {
                   console.error("createQmlObject returned null for line:", line);
               }
           } catch (error) {
               console.error("Error creating QML object for line " + line + ": " + error);
           }

           var onvehicleEndingHandler=function(vehicleId){
               const index=vehiclesList.findIndex(vehicle=>vehicle.vID==vehicleId);

               if(index!=-1){
                   //console.log("on ending destroying vehicle with id:"+vehicleId+"index:"+index);
                   simengine.vehiclesList[index].destroy();
                   simengine.vehiclesList.splice(index, 1);
                   //delete vehiclesList[vehicleId];
               }else{
                   console.log("no vehicle found with id:"+vehicleId)
               }

           }
        newVehicle.vehicleReached.connect(onvehicleEndingHandler);

        return newVehicle;
    }

    function deployVehicle(vehicleId,lane,dir){
        var vehicle =deployMachine(lane,dir,vehicleId);
        vehicles[vehicleId]=vehicle;
        vehiclesList.push(vehicle);
        return vehicle;
    }

    function setVehiclesSpeed(newSpeed){
        for(var i=0;i<vehiclesList.length;i++){
            vehiclesList[i].setSpeed(newSpeed);
        }

    }

    function defineStopRow(vid,vdir,vlane){
        //console.log("inputed iD:"+vid+" vdir: "+vdir+" vlane: "+vlane);
    var resultId=(vdir==45&&vlane=="right")?vid:(vdir==-45&&vlane=="right")?vid-1:
                (vdir==45&&vlane=="left")?vid-2:vid-3;
        //console.log("resultId for Row : "+resultId)
        //console.log("calculated row number: "+(resultId+3)/4)
        return (resultId+3)/4;
    }

    Connections{
        target:trafficCtrl

        function onDeployVehicleSignal(lane,direction){
            //console.log("deploying  vehicle with id:"+simengine.vCount)
            if(simengine.executing){
                deployVehicle(simengine.vCount,lane,direction)
                vCount++;
            }
            if(vCount==countlimit){
                deployed=true

            }
        }
    }

    function simulation(command){
        if(command==true){
            executing=command;

            if(!deployed){
                //console.log("traffic status from simulation func:"+trafficState);
                if(simengine.trafficState=="High Traffic"){
                    trafficCtrl.triggerSimulation(5,(600 / ((30+runspeed*0.15)/50)));
                }else if( simengine.trafficState=="Medium Traffic"){
                    trafficCtrl.triggerSimulation(3,(500 / ((25+runspeed*0.15)/50)));
                }else {//( simengine.trafficState=="Low Traffic")
                    trafficCtrl.triggerSimulation(1,(500 / ((25+runspeed*0.15)/50)));
                }

            }else{
                allVehiclesMovments(command);
            }

        }else{
            executing=command;
            allVehiclesMovments(command);
        }

    }

    function defineZ(lane,direction){

        var zvalue=simengine.definedV_zs.get(lane+direction)
        if(lane=="right"){
            simengine.definedV_zs.set(lane+direction,++zvalue)
            //console.log("lane was right");
        }else{
            simengine.definedV_zs.set(lane+direction,--zvalue)
            //console.log("lane was left")
        }

        return zvalue;
    }

    function primaryZfinder(){
        if(simengine.trafficState=="Low Traffic"){
            return [0,3,4,7];
        }else if(simengine.trafficState=="Medium Traffic"){
            return [0,5,6,11];
        }else{
            return [0,9,10,19];
        }
    }


    function v_stopHandler(clr1){
        var ids45=findV_ids(45);
        var idsM45=findV_ids(-45);

        if(clr1=="red"){
            //console.log("full ids:"+ids45+"Rids:"+idsM45)
            applyStopProcess(ids45,true);
            applyStopProcess(idsM45,false);

        }else{
            //console.log("full ids:"+ids+"Rids:"+Rids)
            applyStopProcess(idsM45,true);
            applyStopProcess(ids45,false);
        }

    }

    function findV_ids(dir){
        var list=[[],[]];
        let ex=0
        var vehiclesCount=(trafficState=="Low Traffic")?4:(trafficState=="Medium Traffic")?6:10;
        //console.log("v dir count:"+vehiclesCount+"lane in dir:"+vehiclesCount/2)
        if(dir==45){
            for(var i=1;ex<vehiclesCount/2;i+=4){
                list[0].push(i);
                ex++;
            }
            ex=0;
            for(var f=3;ex<vehiclesCount/2;f+=4){
                list[1].push(f);
                ex++;
            }
            ex=0;

        }else{
            for(var c=2;ex<vehiclesCount/2;c+=4){
                list[0].push(c);
                ex++;
            }
            ex=0;
            for(var k=4;ex<vehiclesCount/2;k+=4){
                list[1].push(k);
                ex++;
            }

        }

        return list;
    }

    function applyStopProcess(vlists,proc){

        /*for(var obj=0;obj< vehiclesList.length;i++){
            console.log("vehiclesList obj:"+vehiclesList[obj]);
        }*/

        for(var i=0;i<vlists[0].length;i++){
            const vehicleToChange = vehiclesList.find(vehicle => vehicle.vID === vlists[0][i]);
            const RvehicleToChange = vehiclesList.find(vehicle => vehicle.vID === vlists[1][i]);

            if(!vehicleToChange||!RvehicleToChange){
                console.log("didn't find out the object with id:"+vlists[0][i]+"and:"+vlists[1][i]);
            }else{
                console.log("vehiclelist obj founed ids:"+vlists[0][i]+"and"+vlists[1][i]);
                //simengine.vehicles[vlists[i]].moving=move;
                vehicleToChange["stopProcess"]=proc;
                RvehicleToChange["stopProcess"]=proc;
            }
        }
    }

    function resetSim(){
        if(vehiclesList.length>0){
            //console.log("length of the list:"+vehiclesList.length);
        for(var i=vehiclesList.length-1;i>=0;i--){
            if(vehiclesList[i]){
                //console.log("the i"+i)
                //console.log("destroying object:"+vehiclesList[i]);
                vehiclesList[i].destroy();
            }
        }
        }

        vehicles= [{}];
        vehiclesList= [];
        vCount=1;
        executing=false;
        deployed=false;
    }

    function allVehiclesMovments(move){
        for (var Vobjec of vehicles){
            Vobjec.moving=move;
        }
    }


}
