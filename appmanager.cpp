#include "appmanager.h"
#include <QDebug>

AppManager::AppManager(QObject *parent) : QObject{parent}
{
    mb = new modbus(this);
    mb->start();

    connect(mb, &modbus::updateData,[](QVector<quint16> data){
        qDebug() << data;
    });
    connect(mb, &modbus::updateConnectedState,[](bool connected){
        qDebug() << "Connect state: " << connected;
    });
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
