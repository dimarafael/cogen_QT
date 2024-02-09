#include "alarmlistmodel.h"

AlarmListModel::AlarmListModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

int AlarmListModel::rowCount(const QModelIndex &parent) const
{
    return m_alarm_list.size();
}

QVariant AlarmListModel::data(const QModelIndex &index, int role) const
{
    if (index.isValid() && index.row() >= 0 && index.row() < m_alarm_list.size()){
        AlarmItem *alarmItem = m_alarm_list[index.row()];
        switch ((Role)role) {
        case AlarmNumberRole:
            return alarmItem->alarmNumber();
        }
    }
    return {};
}

QHash<int, QByteArray> AlarmListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[AlarmNumberRole] = "alarmNumber";

    return names;
}

void AlarmListModel::processAlarms(QVector<quint16> alarmData)
{
    //initial fill almList by alarms
    if(m_oldAlarmData.size() != alarmData.size()){
        m_oldAlarmData = alarmData;

        for(int nWord = 0; nWord < alarmData.size(); nWord++){
            for(int nBit = 0; nBit < 16; nBit++){
                if(alarmData[nWord] & 1<<nBit){
                    // qInfo() << "add alarm " << nBit+16*nWord;
                    AlarmItem *item =  new AlarmItem(this);
                    item->setAlarmNumber(nBit+16*nWord);
                    m_alarm_list.append(item);
                }
            }
        }
    } else { // add new alarms or remove old
        if(m_oldAlarmData != alarmData){
            // qInfo() << "m_oldAlarmData != alarmData";
            beginResetModel();
            for(int nWord = 0; nWord < alarmData.size(); nWord++){
                for(int nBit = 0; nBit < 16; nBit++){
                    if((alarmData[nWord] & 1<<nBit) && !(m_oldAlarmData[nWord] & 1 << nBit)){
                        // qInfo() << "add alarm " << nBit+16*nWord;
                        AlarmItem *item =  new AlarmItem(this);
                        item->setAlarmNumber(nBit+16*nWord);
                        m_alarm_list.append(item);
                    } else if(!(alarmData[nWord] & 1<<nBit) && (m_oldAlarmData[nWord] & 1 << nBit)){
                        // qInfo() << "remove alarm " << nBit+16*nWord;
                        for(int i =0; i < m_alarm_list.size(); i++){
                            if(m_alarm_list[i]->alarmNumber() == (nBit+16*nWord)) m_alarm_list.remove(i, 1);
                        }
                    }
                }
            }
            endResetModel();
            m_oldAlarmData = alarmData;
        }
    }
}
