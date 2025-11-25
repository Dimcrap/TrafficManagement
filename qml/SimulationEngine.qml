import QtQuick 2.15

Item {

    id:simengine
    property int areawidth: 500
    property int areaHeight: 480

    function diployMachine(road,line){
    var position ;
        if(road==45&&line=="right"){
        position=Qt.point(areawidth*0.2,areaHeight*0.85);
    }
    var imageQml = `
        import QtQuick 2.15
        Image {
            source: "qrc:/images/isocars/Vright1.png"
            property real baseX:${position.x}
            property real baseY:${position.y}
            x:baseX-areaWidth *0.0085
            y:baseY -areaHeight * 0.02
            width: 50
            height: 50
        }
    `;
        //property point basePosition: Qt.point(${position.x}, ${position.y})
        var imageObj=vehicleImage=Qt.createQmlObject(imageQml,simengine,"dynamicImage");
        return vehicleImage
        //return Qt.createQmlObject(imageQml,simengine,"dynamicImage");
    }

    /*function updatePos(x,y){
            if(vehicleImage){
                vehicleImage.x=x;
                vehicleImage.y=y;
                vehicleImage.basePosition =Qt.point(x,y);
            }
        }*/


}
