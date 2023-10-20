#ifndef ALARMLIST_H
#define ALARMLIST_H

#include <QObject>
#include <QVector>
#include <QDebug>

class AlarmList : public QObject
{
    Q_OBJECT
public:
    explicit AlarmList(QObject *parent = nullptr);

    bool checkAlarms(QVector<quint16> *almV, QList<int> *almList);
signals:

private:
    QVector<quint16> *oldAlmV;

};

#endif // ALARMLIST_H
