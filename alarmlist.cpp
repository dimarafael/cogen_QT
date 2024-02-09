#include "alarmlist.h"

AlarmList::AlarmList(QObject *parent)
    : QObject{parent}
{
    oldAlmV = new QVector<quint16>();
}

bool AlarmList::checkAlarms(QVector<quint16> *almV, QList<int> *almList)
{
    bool result = false;

    //initial fill almList by alarms
    if(oldAlmV->size() != almV->size()){
        oldAlmV = new QVector<quint16>(*almV);
        result = true;
        almList->clear();
        for(int i = 0; i < almV->size(); i++){
            for(int j = 0; j < 16; j++){
                if(almV->data()[i] & 1<<j){
                    // qInfo() << "add alarm " << j+16*i;
                    almList->push_back(j+16*i);
                }
            }
        }
    } else { // add new alarms or remove old
        if(*almV != *oldAlmV){
            for(int i = 0; i < almV->size(); i++){
                // qInfo() << almV->data()[i];
                for(int j = 0; j < 16; j++){
                    //add new alarm to list
                    if((almV->data()[i] & 1<<j) && !(oldAlmV->data()[i] & 1<<j)){
                        // qInfo() << "add alarm " << j+16*i;
                        almList->push_back(j+16*i);
                    }
                    //remove alarm from list
                    if(!(almV->data()[i] & 1<<j) && (oldAlmV->data()[i] & 1<<j)){
                        // qInfo() << "remove alarm " << j+16*i;
                        for(int iv = 0; iv < almList->size(); iv++){
                            if(almList->data()[iv] == j+16*i)
                                almList->removeAt(iv);
                        }
                    }
                }
            }
            oldAlmV = new QVector<quint16>(*almV);
            result = true;
        };
    }

    return result;
}
