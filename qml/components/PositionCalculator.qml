import QtQuick 2.15

Item {

    property point defaultTileSize: Qt.point(30,30)
    property point gridScreen: Qt.point(1200)


    function worldToScreen(worldCoord,tileSize = defaultTileSize){
        return Qt.point(
                (worldCoord.x - worldCoord.y) * (tileSize.x /2),
                (worldCoord.x - worldCoord.y) * (tileSize.y /2)
                    )
    }

}
