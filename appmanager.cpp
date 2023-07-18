#include "appmanager.h"
#include <QDebug>
#include <QThread>


AppManager::AppManager(QObject *parent) : QObject{parent}
{
    QThread *thread = new QThread;
    mb = new modbus();
    connect(thread, &QThread::started, mb, &modbus::pollModbus);
    mb->moveToThread(thread);
    thread->start();

    auto parseModbusResponse = [&](QVector<quint16> data){
        qDebug() << data;
        setIsButton1(data[0]>0);
    };

    connect(mb, &modbus::updateData, parseModbusResponse);

    auto updateConnectedState = [&](bool connected){
        setIsModbusConnected(connected);
        qDebug() << "Connect state: " << connected;
    };
    connect(mb, &modbus::updateConnectedState,updateConnectedState);

    connect(this, &AppManager::writeRegister, mb, &modbus::writeHoldingRegister);
}

AppManager::~AppManager()
{
//    mb->exit();
//    mb->wait();
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

void AppManager::onClickButton1(bool val)
{
    qDebug()<< "Button 1 clicked, value: " << val;
    setIsButton1(val);
    qint16 value = val?1:0;
    emit writeRegister(0,value);
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
