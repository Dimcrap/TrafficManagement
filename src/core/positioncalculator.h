#ifndef POSITIONCALCULATOR_H
#define POSITIONCALCULATOR_H

#include <QObject>
#include <QPoint>
#include <QPointF>
#include <QSize>

class PositionCalculator :public QObject
{

    Q_OBJECT
    Q_PROPERTY(double tileWidth READ getTileWidth NOTIFY tileSizeChanged )
    Q_PROPERTY(double tileHeight READ getTileHeight NOTIFY tileSizeChanged )

private:
    double m_tileWidth;
    double m_tileHeight;

public:

    PositionCalculator(QObject * parent =nullptr);

    Q_INVOKABLE QPointF screenToIso(QPoint screen) const;
    Q_INVOKABLE QPoint isoToScreen(QPointF isometric) const;
    Q_INVOKABLE QPointF snapToGrid(double isoX, double isoY) const;

    Q_INVOKABLE void calculateTileSize(double containerWidth, double containerHeight, int gridTileX, int gridTileY);
    Q_INVOKABLE void setTileSize(double width, double height);
    double getTileWidth() const { return m_tileWidth; }
    double getTileHeight() const { return m_tileHeight; }

signals:
 void  tileSizeChanged();

};

#endif // POSITIONCALCULATOR_H
