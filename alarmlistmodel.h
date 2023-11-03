#ifndef ALARMLISTMODEL_H
#define ALARMLISTMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include "alarmitem.h"

class AlarmListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Role {
        AlarmNumberRole = Qt::UserRole + 1
    };
    explicit AlarmListModel(QObject *parent = nullptr);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
public slots:
    void processAlarms(const QVector<quint16> alarmData);

private:
    QList<AlarmItem*> m_alarm_list;
    QVector<quint16> m_oldAlarmData;
};

#endif // ALARMLISTMODEL_H
