#ifndef POSITIONCALCULATOR_H
#define POSITIONCALCULATOR_H

#include <QObject>
#include <QPoint>
#include <QPointF>
#include <QSize>
#include <cmath>
#include <QLineF>

class PositionCalculator :public QObject
{

    Q_OBJECT
    Q_PROPERTY( double tileWidth READ getTileWidth NOTIFY tileSizeChanged )
    Q_PROPERTY( double tileHeight READ getTileHeight NOTIFY tileSizeChanged )
    Q_PROPERTY( QPoint origin READ getOriginPoint NOTIFY originChanged )

private:
    double m_tileWidth;
    double m_tileHeight;
    QPoint m_origin;


public:

    PositionCalculator(QObject * parent =nullptr);

    Q_INVOKABLE QPointF screenToIso(QPoint screen) const;
    Q_INVOKABLE QPointF isoToScreen(QPointF isometric) const;
    Q_INVOKABLE QPointF snapToGrid(double isoX, double isoY) const;
    Q_INVOKABLE QPointF getnextMovement(QString lane,float angle,QPoint  currentPos)const;
    Q_INVOKABLE double calculateAngle(QPointF startPos,QPointF endPos) const;
    Q_INVOKABLE QPointF moveToward(QPoint currentPos,QPointF targetPos,double speed)const;
    Q_INVOKABLE void calculateTileSize(double containerWidth, double containerHeight, int gridTileX, int gridTileY);
    Q_INVOKABLE void calculateOrigin(double containerWidth,double containerHeight);
    Q_INVOKABLE void setTileSize(double width, double height);

    double getTileWidth() const { return m_tileWidth; }
    double getTileHeight() const { return m_tileHeight; }
    QPoint getOriginPoint() const{ return m_origin; }

signals:
    void  tileSizeChanged();
    void  originChanged();

};

#endif // POSITIONCALCULATOR_H
