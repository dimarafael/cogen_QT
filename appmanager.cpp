#include "appmanager.h"
#include <QDebug>



AppManager::AppManager(QObject *parent) : QObject{parent}
{
    mb = new modbus(this);
    mb->start();

    connect(mb, &modbus::updateData,[](QVector<quint16> data){
        qDebug() << data;
    });

    auto updateConnectedState = [&](bool connected){
        setIsModbusConnected(connected);
        qDebug() << "Connect state: " << connected;
    };
    connect(mb, &modbus::updateConnectedState,updateConnectedState);
}

AppManager::~AppManager()
{
    mb->exit();
    mb->wait();
}

bool AppManager::isButton1() const
{
    return m_isButton1;
}

void AppManager::setIsButton1(bool newIsButton1)
{
    if (m_isButton1 == newIsButton1)
        return;
    m_isButton1 = newIsButton1;
    emit isButton1Changed();
}

void AppManager::performOperation()
{

}

bool AppManager::isModbusConnected() const
{
    return m_isModbusConnected;
}

void AppManager::setIsModbusConnected(bool newIsModbusConnected)
{
    if (m_isModbusConnected == newIsModbusConnected)
        return;
    m_isModbusConnected = newIsModbusConnected;
    emit isModbusConnectedChanged();
}
