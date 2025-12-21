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

QPointF PositionCalculator::getnextMovement(QString lane, float angle, QPoint currentPos) const
{
    double mathAngleDeg = 90.0 - angle;  // Adjust for coordinate system
    if (mathAngleDeg < 0) mathAngleDeg += 360.0;

    double angleRad=(angle * M_PI /180.0);

    double speed=2.0;

    double dx=cos(angleRad)* speed;
    double dy=sin(angleRad)* speed;

    dy=-dy;

    if(angle>0&&lane=="right"){
    return QPointF(currentPos.x()+dx,currentPos.y()+dy);
      //  qDebug()<<"right lane pos gived";
       // return QPoint(currentPos.x()+1.99999,currentPos.y()-0.00000000000002842177);
    }else if(angle>0&&lane=="left"){
        return QPoint(currentPos.x()-1,currentPos.y()+1);
    }else if(angle<0&&lane=="right"){
        return QPoint(currentPos.x()-2,currentPos.y()-1);
    }else{
        return QPoint(currentPos.x()+2,currentPos.y()+1);
    }

}

double PositionCalculator::calculateAngle(QPointF startPos, QPointF endPos) const
{

    QLineF line(startPos,endPos);
    double qtAngle =line.angle();

    double dx = endPos.x() - startPos.x();
    double dy = endPos.y() - startPos.y();
    double mathAngleRad = atan2(dy, dx);
    double mathAngleDeg = mathAngleRad * 180.0 / M_PI;

       if (mathAngleDeg < 0) mathAngleDeg += 360.0;
      // qDebug() << "Math angle (atan2):" << mathAngleDeg << "degrees";
       //qDebug() << "Difference:" << (qtAngle - mathAngleDeg);

       return qtAngle;

}

QPointF PositionCalculator::moveToward(QPoint currentPos, QPointF targetPos, double speed) const
{
    qDebug() << "moveToward called with currentPos:" << currentPos
             << "targetPos:" << targetPos;
    double dx = targetPos.x() - currentPos.x();
    double dy = targetPos.y() - currentPos.y();

    // Calculate distance to target
    double distance = sqrt(dx*dx + dy*dy);

    // If we're at or very close to target, return target
    if (distance <= speed) {
        return targetPos;
    }

    // Normalize the vector (make it unit length)
    double unitX = dx / distance;
    double unitY = dy / distance;
    return QPointF(
        currentPos.x() + unitX * speed,
        currentPos.y() + unitY * speed
        );
}

QPointF PositionCalculator::stopPoint(QPointF startPos, QPointF endPos, int sec)
{
    //qDebug() << "Start:" << startPos << "End:" << endPos ;

    double percentage=40;
    if (percentage > 1.0) percentage /= 100.0;
    percentage = qBound(0.0, percentage, 1.0);

    // SIMPLE vector interpolation - no angles needed!
    return QPointF(
        startPos.x() + (endPos.x() - startPos.x()) * percentage,
        startPos.y() + (endPos.y() - startPos.y()) * percentage
        );
}

void PositionCalculator::setTileSize(double width, double height)
{
    m_tileWidth=width;
    m_tileHeight=height;

    emit tileSizeChanged();
}
