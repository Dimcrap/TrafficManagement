#ifndef POSITIONCALCULATOR_H
#define POSITIONCALCULATOR_H

#include <QObject>
#include <QPoint>
#include <QPointF>
#include <QSize>

class PositionCalculator :public QObject
{

    Q_OBJECT

public:

    PositionCalculator(QObject * parent =nullptr);

    Q_INVOKABLE QPointF screenToIso(QPoint screen) const;
    Q_INVOKABLE QPoint isoToScreen(QPointF isometric) const;
    Q_INVOKABLE QPointF snapToGrid(double isoX, double isoY) const;

    Q_INVOKABLE void setTileSize(double width, double height);
    Q_INVOKABLE double getTileWidth() const { return m_tileWidth; }
    Q_INVOKABLE double getTileHeight() const { return m_tileHeight; }
signals:
 void  tileSizeChanged();

private:
    double m_tileWidth;
    double m_tileHeight;

};

#endif // POSITIONCALCULATOR_H
