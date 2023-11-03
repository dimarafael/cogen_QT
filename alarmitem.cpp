#include "alarmitem.h"

AlarmItem::AlarmItem(QObject *parent)
    : QObject{parent}
{

}

int AlarmItem::alarmNumber() const
{
    return m_alarmNumber;
}

void AlarmItem::setAlarmNumber(int newAlarmNumber)
{
    if (m_alarmNumber == newAlarmNumber)
        return;
    m_alarmNumber = newAlarmNumber;
    emit alarmNumberChanged();
}
