#ifndef ALARMITEM_H
#define ALARMITEM_H

#include <QObject>

class AlarmItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int alarmNumber READ alarmNumber WRITE setAlarmNumber NOTIFY alarmNumberChanged FINAL)
public:
    explicit AlarmItem(QObject *parent = nullptr);

    int alarmNumber() const;
    void setAlarmNumber(int newAlarmNumber);

signals:

    void alarmNumberChanged();
private:
    int m_alarmNumber;
};

#endif // ALARMITEM_H
