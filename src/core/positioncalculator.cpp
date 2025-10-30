#include "positioncalculator.h"
#include <cmath>

PositionCalculator::PositionCalculator(QObject * parent)
    :QObject(parent),m_tileWidth(64.0),
    m_tileHeight(32.0)
{
}




QPointF PositionCalculator::screenToIso(QPoint screen) const
{
    double x= static_cast<double>(screen.x());
    double y= static_cast<double>(screen.y());

    double isoX=(x/m_tileWidth+y/m_tileHeight)/2;
    double isoY=(y/m_tileHeight-x/m_tileWidth)/2;

    return QPointF(isoX,isoY);
}


QPoint PositionCalculator::isoToScreen(QPointF isometric) const
{
    int screenX=static_cast<int>(isometric.x()-isometric.y() *m_tileWidth);
    int screenY=static_cast<int>(isometric.x()+isometric.y() *m_tileHeight);

    return QPoint(screenX,screenY);
}

QPointF PositionCalculator::snapToGrid(double isoX, double isoY) const
{
    return QPointF(std::round(isoX),std::round(isoY));
}

void PositionCalculator::setTileSize(double width, double height)
{
    m_tileWidth=width;
    m_tileHeight=height;
    emit tileSizeChanged();

}
