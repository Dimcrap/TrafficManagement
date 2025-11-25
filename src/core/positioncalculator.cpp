#include "positioncalculator.h"
#include <cmath>
#include <QDebug>

PositionCalculator::PositionCalculator(QObject * parent)
    :QObject(parent),m_tileWidth(64.0),
    m_tileHeight(32.0),
    m_origin(0,0)
{
}

void PositionCalculator::calculateTileSize(double containerWidth, double containerHeight, int gridTileX, int gridTileY)
{
    double maxTileWidthFromWidth = (containerWidth * 0.9) / gridTileX;
    double maxTileWidthFromHeight = (containerHeight * 0.8) /gridTileY * 2;

    m_tileWidth = std::min(maxTileWidthFromWidth,maxTileWidthFromHeight);
    m_tileHeight = m_tileWidth/2;

    emit tileSizeChanged();
}

void PositionCalculator::calculateOrigin(double containerWidth,double containerHeight){

    m_origin.setX(containerWidth/2-(m_tileWidth/2));
    m_origin.setY(containerHeight-containerHeight* 0.98);

    emit originChanged();
}

QPointF PositionCalculator::screenToIso(QPoint screen) const
{
    double x= static_cast<double>(screen.x());
    double y= static_cast<double>(screen.y());

    double isoX=(x/m_tileWidth+y/m_tileHeight)/2;
    double isoY=(y/m_tileHeight-x/m_tileWidth)/2;

    return QPointF(isoX,isoY);
}



QPointF PositionCalculator::isoToScreen(QPointF isometric) const
{
    double screenX=(isometric.x() * (m_tileWidth/2.0)) -
                  (isometric.y()* (m_tileWidth /2.0))+m_origin.x();
    double screenY=(isometric.x() * m_tileHeight/2.0) +
                  (isometric.y() * (m_tileHeight /2.0))+m_origin.y();


    return QPoint(screenX,screenY);
}


QPointF PositionCalculator::snapToGrid(double isoX, double isoY) const
{
    return QPointF(std::round(isoX),std::round(isoY));
}

QPointF PositionCalculator::getnextMovement(std::string lane, int dir, QPoint currentPos) const
{

}

void PositionCalculator::setTileSize(double width, double height)
{
    m_tileWidth=width;
    m_tileHeight=height;

    emit tileSizeChanged();
}
