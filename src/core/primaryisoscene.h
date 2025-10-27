#ifndef PRIMARYISOSCENE_H
#define PRIMARYISOSCENE_H

#include <QObject>
#include <QPointF>
#include <QMap>
#include <QString>

class primaryisoscene :public QObject
{
    Q_OBJECT

public:

    explicit primaryisoscene(QObject * parent=nullptr);

    Q_INVOKABLE void addPermanentObject(const QString & objectId,const QString & type);


};

#endif // PRIMARYISOSCENE_H
