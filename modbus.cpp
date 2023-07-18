#include "modbus.h"


void modbus::pollModbus(){
    mc->connectDevice();
    timer->start(1000);
    connect(timer, &QTimer::timeout, this, &modbus::timerTimeout);
}

//Query result processing
void modbus::processReplyResult()
{
    auto reply = qobject_cast<QModbusReply *>(sender());
    if (!reply)
        return;

    if(!reply->error()){
        emit updateData(reply->result().values());
    }
    reply->deleteLater();
}

//ModbusClient state changed
void modbus::processStateChanged(QModbusClient::State state)
{
    if(mc->state() == QModbusDevice::ConnectedState){
        emit updateConnectedState(true);
    } else{
        emit updateConnectedState(false);
    }
}

// Timer timeout function
void modbus::timerTimeout()
{
    if(mc->state() == QModbusDevice::ConnectedState){
        auto *reply = mc->sendReadRequest(*du,1);
        if(reply->isFinished()){
            delete reply;
        } else{
            connect(reply, &QModbusReply::finished, this, &modbus::processReplyResult);
        }
    } else if (mc->state() == QModbusDevice::UnconnectedState){
        mc->connectDevice();
    }
}

modbus::modbus(){
    mc = new QModbusTcpClient(this);
    mc->setConnectionParameter(QModbusDevice::NetworkAddressParameter, "127.0.0.1");
    mc->setConnectionParameter(QModbusDevice::NetworkPortParameter, 502);
    timer = new QTimer(this);
    vData = new QVector<quint16>(4);
    du = new QModbusDataUnit(QModbusDataUnit::HoldingRegisters,0,*vData);
    connect(mc, &QModbusClient::stateChanged, this, &modbus::processStateChanged);
}

modbus::~modbus(){
    mc->disconnect();
}

void modbus::writeHoldingRegister(int addr, qint16 value){
    QVector<quint16> vDataWrite(1);
    vDataWrite[0] = value;
    QModbusDataUnit duForWrite(QModbusDataUnit::HoldingRegisters, addr, vDataWrite);
    mc->sendWriteRequest( duForWrite,1);
}

