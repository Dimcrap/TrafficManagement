import QtQuick 2.15

Item {

    id:simengine
    property int areawidth: 500
    property int arealength: 480


    function diployMachine(road,line){
    var position ;
        if(road==45&&line=="right"){
        position=Qt.point(areawidth*0.2,arealength*0.85);
    }
    var imageQml = `
        import QtQuick 2.15
        Image {
            source: "qrc:/images/isocars/Vright1.png"
            x:${position.x}
            y:${position.y}
                   width: 50
                   height: 50
        }
    `;
        return Qt.createQmlObject(imageQml,simengine,"dynamicImage");
    }



}
